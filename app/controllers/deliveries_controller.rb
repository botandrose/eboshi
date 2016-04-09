class DeliveriesController < ApplicationController
  before_filter :get_client, :get_invoice, :authorized?

  def new
    @delivery = Delivery.new({
      invoice: @invoice,
      reply_to: current_user.email,
      subject: "Invoice ##{@invoice.id}"
    })
  end

  def create
    @delivery = Delivery.new(params[:delivery].merge(pdf: pdf, invoice: @invoice))
    @delivery.send
    redirect_to [@client, :invoices], notice: "Invoice sent to #{@client.email}"
  end

  private

  def pdf
    render_to_string pdf: "invoice-#{@invoice.id}", template: "invoices/show.pdf.haml", encoding: "UTF-8"
  end

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

