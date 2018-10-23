class PaymentsController < ApplicationController
  before_action :get_invoice
  before_action :authorized?

  def new
    @payment = @invoice.payments.build(params[:payment] || { total: @invoice.balance })
  end

  def create
    @payment = @invoice.payments.build params[:payment]
    if @payment.save
      flash[:notice] = "Payment successfully created."
      redirect_to invoices_path(@invoice.client)
    else
      render :new
    end
  end

  protected

  def get_invoice
    @invoice = Invoice.find params[:invoice_id]
  end

  def authorized?
    current_user.authorized? @invoice
  end
end
