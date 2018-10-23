class InvoicesController < ApplicationController
  before_action :get_client, :authorized?

  def index
    @invoices = @client.invoices_with_unbilled
    current_user.update_attribute(:last_client, @client)
    respond_to do |wants|
      wants.html
      wants.js { render @client.invoices.paid }
    end
  end

  def show
    @invoice = @client.invoices.find(params[:id])
    respond_to do |wants|
      wants.html { render layout: false }
      wants.js { render partial: 'mini', locals: { invoice: @invoice } }
      wants.pdf do
        filename = "#{current_user.business_name_or_name.parameterize}_invoice-\##{@invoice.id}.pdf"
        render pdf: filename, show_as_html: params[:debug].present?
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
      redirect_to invoices_path(@client), notice: "Invoice successfully created."
    else
      render :new
    end
  end

  def edit
    @invoice = @client.invoices.find(params[:id])
    respond_to do |wants|
      wants.html
      wants.js { render partial: 'full', locals: { invoice: @invoice } }
    end
  end

  def update
    @invoice = @client.invoices.find(params[:id])
    if @invoice.update_attributes(params[:invoice])
      redirect_to invoices_path(@client), notice: "Invoice successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @invoice = @client.invoices.find(params[:id])
    @invoice.destroy
    redirect_to invoices_path(@client)
  end

  private

  def get_client
    @client = Client.includes(:assignments).find(params[:client_id])
  end

  def authorized?
    current_user.authorized?(@client)
  end
end
