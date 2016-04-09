class Delivery
  include ActiveModel::Model

  attr_accessor :invoice, :reply_to, :pdf

  def send
    Mailer.new_invoice(invoice, reply_to, pdf).deliver_now
  end
end
