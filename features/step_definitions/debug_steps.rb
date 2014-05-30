Then /^debug(?:ger)?$/ do
  debugger
  stop_here = 1
end

Then "what" do
  display do
    where
    html
    how
    where
  end
end

Then "pending" do
  pending @__executor.instance_variable_get("@feature_file")
end

Then "screenshot" do
  page.driver.render "~/screenshot.png"
end
