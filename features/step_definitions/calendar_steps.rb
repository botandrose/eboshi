Then "I should see the following calendar total:" do |table|
  actual = all("#calendar_summary li").map do |li|
    [li.text]
  end
  table.diff! actual
end
