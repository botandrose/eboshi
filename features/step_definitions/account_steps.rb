When /^I upload a logo image$/ do
  attach_file "Logo", "features/support/images/logo.gif"
end

When /^I upload a signature$/ do
  attach_file "Signature", "features/support/images/signature.gif"
end

Then /^the logo should say "([^\"]*)"$/ do |text|
  page.should have_css("#logo", text: text)
end

Then /^the signature should say "([^\"]*)"$/ do |text|
  page.should have_css("#sig", text: text)
end

Then /^the logo should be an image$/ do
  page.should have_css("#logo img")
end

Then /^the signature should be an image$/ do
  page.should have_css("#sig img")
end



