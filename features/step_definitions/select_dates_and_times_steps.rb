require "xpath" # XPath is a separate gem now

module Cucumber
  module Rails
    module CapybaraSelectDatesAndTimes
      def select_date(field, options = {})
        id = find("label:contains('#{field}')")["for"]
        date = Date.parse(options[:with])
        find("select##{id}_1i option[value='#{date.year}']").select_option
        find("select##{id}_2i option[value='#{date.month}']").select_option
        find("select##{id}_3i option[value='#{date.day}']").select_option
      end

      def select_time(field, options = {})
        id = find("label:contains('#{field}')")["for"]
        time = Time.parse(options[:with])
        find("select##{id}_4i option[value='#{time.hour.to_s.rjust(2,'0')}']").select_option
        find("select##{id}_5i option[value='#{time.min.to_s.rjust(2,'0')}']").select_option
      end

      def select_datetime(field, options = {})
        select_date(field, options)
        select_time(field, options)
      end
    end
  end
end

World(Cucumber::Rails::CapybaraSelectDatesAndTimes)

When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" time$/ do |time, selector|
  select_time(selector, :with => time)
end

When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date$/ do |date, selector|
  select_date(selector, :with => date)
end

When /^(?:|I )select "([^\"]*)" as the "([^\"]*)" date and time$/ do |datetime, selector|
  select_datetime(selector, :with => datetime)
end
