class DeliveriesController < ApplicationController
  before_filter :get_client, :get_invoice, :authorized?

  def new
    @delivery = Delivery.new(invoice: @invoice)
  end

  def create
    pdf = render_to_string pdf: "invoice-#{@invoice.id}", template: "invoices/show.pdf.haml", encoding: "UTF-8"
    Delivery.new(invoice: @invoice, reply_to: current_user.email, pdf: pdf).send
    redirect_to [@client, :invoices], notice: "Invoice sent to #{@client.email}"
  end

  private

  def get_client
    @client = Client.includes(:assignments).find(params[:client_id])
  end

  def get_invoice
    @invoice = @client.invoices.find(params[:invoice_id])
  end

  def authorized?
    current_user.authorized?(@client)
  end
end

