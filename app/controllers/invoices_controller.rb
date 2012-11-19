class InvoicesController < ApplicationController
  before_filter :get_client, :authorized?

  def index
    @invoices = @client.invoices_with_unbilled
    current_user.update_attribute(:last_client, @client)
    respond_to do |wants|
      wants.html
      wants.js { render @client.invoices.paid }
    end
  end

  def show
    @invoice = @client.invoices.find params[:id]
    respond_to do |wants|
      wants.html { render :layout => false }
      wants.js { render :partial => 'mini', :locals => { :invoice => @invoice } } 
      wants.pdf do
        require 'prince'
        prince = Prince.new()
        prince.add_style_sheets "#{Rails.root}/public/stylesheets/invoice.css"
        # Set RAILS_ASSET_ID to blank string or rails appends some time after 
        # to prevent file caching, fucking up local - disk requests.
        ENV["RAILS_ASSET_ID"] = ''
        html_string = render_to_string :template => 'invoices/show', :formats => [:html], :layout => false

        # Make all paths relative, on disk paths...
        html_string = html_string.gsub("src=\"", "src=\"#{Rails.root}/public") unless Rails.env == "production"
        
        # Send the generated PDF file from our html string.
        send_data(
          prince.pdf_from_string(html_string),
          :filename => "#{current_user.business_name_or_name.parameterize}_invoice-\##{@invoice.id}.pdf",
          :type => 'application/pdf',
          :disposition => 'inline'
        )
      end
    end
  end

  def new
    @invoice = @client.build_invoice_from_unbilled(params[:line_item_ids])
  end

  def create
    @invoice = @client.invoices.build
    @invoice.attributes = params[:invoice]
    if @invoice.save
      flash[:notice] = "Invoice successfully created."
      redirect_to invoices_path(@client)
    else
      render :new
    end
  end

  def edit
    @invoice = @client.invoices.find params[:id]
    respond_to do |wants|
      wants.html
      wants.js { render :partial => 'full', :locals => { :invoice => @invoice } } 
    end
  end

  def update
    @invoice = @client.invoices.find params[:id]

    # HACK: this is bullshit. AR is broken?
    line_item_ids = (params[:invoice].delete(:line_item_ids) || []).collect(&:to_i)
    @invoice.line_items.each do |line_item|
      line_item.update_attribute :invoice_id, nil unless line_item_ids.include?(line_item.id)
    end
    @invoice.reload

    if @invoice.update_attributes params[:invoice]
      flash[:notice] = "Invoice successfully updated."
      redirect_to invoices_path(@client)
    else
      render :edit
    end
  end

  def destroy
    @invoice = @client.invoices.find params[:id]
    @invoice.destroy
    redirect_to invoices_path(@client)
  end

  private
    def get_client
      @client = Client.find params[:client_id], :include => :assignments
    end

    def authorized?
      current_user.authorized? @client
    end      
end
