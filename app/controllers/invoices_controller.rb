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
        filename = "#{current_user.business_name_or_name.parameterize}_invoice-\##{@invoice.id}.pdf"
        render :pdf => filename, :show_as_html => params[:debug].present?
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
