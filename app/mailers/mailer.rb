class Mailer < ActionMailer::Base
  default from: "info@botandrose.com"

  def new_invoice invoice, pdf, reply_to, subject, body
    attachments["invoice-#{invoice.id}.pdf"] = pdf
    mail to: invoice.client.email,
      reply_to: reply_to,
      subject: subject,
      body: body
  end
end
