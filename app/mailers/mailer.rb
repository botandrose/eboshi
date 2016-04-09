class Mailer < ActionMailer::Base
  default from: "info@botandrose.com"

  def new_invoice invoice, reply_to, pdf
    attachments["invoice-#{invoice.id}.pdf"] = pdf
    mail to: invoice.client.email,
      reply_to: reply_to,
      subject: "Invoice ##{invoice.id}"
  end
end
