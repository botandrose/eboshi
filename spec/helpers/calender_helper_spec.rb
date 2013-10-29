require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

include CalendarHelper

describe CalendarHelper do
  describe "calendar" do
    before do
      helper.extend Haml
      helper.extend Haml::Helpers 
      helper.send :init_haml_helpers
    end

    it "should accept a block for date html" do
      Delorean.time_travel_to "1983-06-19" do
        opts = {
          :year => 1983, 
          :month => 6
        }

        out = helper.capture_haml do
          helper.calendar(opts) do |date|
            helper.haml_concat "day"
          end
        end

        out.should have_selector "tbody tr", :count => 5
        out.should have_selector "tbody tr:first-child td", :count => 7
        out.should have_selector "tbody tr:first-child td.otherMonth", :count => 3
        out.should have_selector "tbody tr:last-child td.otherMonth", :count => 2

        out.should have_selector "tbody td.today", :count => 1
        out.should have_selector "tbody tr:nth-child(4) td:first-child.today", :count => 1
      end
    end

    it "should not suck" do
      opts = {
        :year => 2009, 
        :month => 11
      }

      out = helper.capture_haml do
        helper.calendar(opts) do |date|
          helper.haml_concat "day"
        end
      end

      out.should have_selector "tbody tr", :count => 5
      out.should have_selector "tbody tr:first-child td", :count => 7
    end
  end
  
  describe "link_to_previous_month" do
    it "should return a link to the previous month" do
      html = link_to_previous_month(Date.parse("1983/6/1"))
      html.should match /prev/
      html.should match %r{/calendar/1983/5}
    end
    it "should do date math right" do
      html = link_to_previous_month(Date.parse("1983/1/1"))
      html.should match %r{/calendar/1982/12}
    end
  end
  
  describe "link_to_next_month" do
    it "should return a link to the next month" do
      html = link_to_next_month(Date.parse("1983/6/1"))
      html.should match /next/
      html.should match %r{/calendar/1983/7}
    end
    it "should do date math right" do
      html = link_to_next_month(Date.parse("1983/12/1"))
      html.should match %r{/calendar/1984/1}
    end
  end
end
