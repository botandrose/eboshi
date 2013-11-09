Then "I should see the following activity summary:" do |table|
  actual = all("#summaries tr").map do |row|
    row.all("th,td").map(&:text)
  end
  table.diff! actual
end

Then "I should see the following clients:" do |table|
  actual = all("#clients_summary tr").map do |row|
    row.all("th,td").map(&:text)[0..1]
  end
  table.diff! actual
end

Then "I should see the following collaborators:" do |table|
  actual = all("#collaborators li span").map do |li|
    [li.text]
  end
  table.diff! actual
end

Then "I should see the following existing users:" do |table|
  actual = all("#existing_users li").map do |li|
    [li.text]
  end
  table.diff! actual
end
