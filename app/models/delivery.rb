class Delivery
  include ActiveModel::Model

  attr_accessor :invoice, :pdf, :reply_to, :subject, :body

  def send
    Mailer.new_invoice(invoice, pdf, reply_to, subject, body).deliver_now
  end
end
