When /^I upload a logo image$/ do
  attach_file "Logo", Rails.root.join("features/support/images/logo.gif")
end

When /^I upload a signature$/ do
  attach_file "Signature", Rails.root.join("features/support/images/signature.gif")
end

Then /^the logo should say "([^\"]*)"$/ do |text|
  expect(page).to have_css("#logo", text: text)
end

Then /^the signature should say "([^\"]*)"$/ do |text|
  expect(page).to have_css("#sig", text: text)
end

Then /^the logo should be an image$/ do
  expect(page).to have_css("#logo img")
end

Then /^the signature should be an image$/ do
  expect(page).to have_css("#sig img")
end
