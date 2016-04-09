require "email_spec/cucumber"
require "nokogiri"

Then /^(?:I|they|"([^"]*?)") should receive (an|no|\d+) emails? from "(.*)"$/ do |address, amount, sender|
  emails = unread_emails_for(address)
  emails.size.should == parse_email_count(amount)
  emails.each do |email|
    email.should be_delivered_from(sender)
  end
end

Then /^I should see "(.+?)" as the reply to address$/ do |reply_to|
  current_email.should have_reply_to(reply_to)
end

Then /^(?:I|they) should see the following in the email body:$/ do |text|
  current_email.default_part_body.to_s.should include(text)
end

Then /^"(.*?)" should (?:all |)receive an email from "(.*?)" with the subject "(.*?)" and the following body:$/ do |recipients, from, subject, body|
  recipients.split(", ").each do |address|
    emails = unread_emails_for(address)
    open_email(address, with_subject: subject)
    current_email.should be_delivered_from(from)
    current_email.default_part_body.to_s.should include(body)
  end
end

Then /^"(.*?)" should (?:all |)receive an email from "(.*?)" with the subject "(.*?)" and the following html body:$/ do |recipients, from, subject, body|
  recipients.split(", ").each do |address|
    emails = unread_emails_for(address)
    open_email(address, with_subject: subject)
    current_email.should be_delivered_from(from)
    Nokogiri::HTML(current_email.body.to_s).text.should include(body)
  end
end

Then /^I should see (an|no|\d+) attachments? named "([^"]*?)"$/ do |amount, filename|
  current_email_attachments.select { |a| a.filename == filename }.size.should == parse_email_count(amount)
end

