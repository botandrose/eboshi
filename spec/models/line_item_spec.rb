require "spec_helper"

describe LineItem do
  describe ".unbilled" do
    it "excludes billed line items" do
      unbilled = Work.make :invoice => nil
      billed = Work.make :invoice => Invoice.make
      LineItem.unbilled.should == [unbilled]
    end
  end

  describe ".on_date" do
    it "filters out line items not on supplied date" do
      yesterday = Work.make :start => Time.zone.parse("2012-6-30 23:59:59")
      today = Work.make :start => Time.zone.parse("2012-7-1 00:00:00")
      tomorrow = Work.make :start => Time.zone.parse("2012-7-2 00:00:00")
      LineItem.on_date(Time.zone.parse("2012-7-1 23:59:59")).should == [today]
    end
  end

  describe ".on_week" do
    it "filters out line items not on supplied date's week" do
      # 2012-7-1 is a sunday
      last_week = Work.make :start => Time.zone.parse("2012-6-30 23:59:59")
      this_week = Work.make :start => Time.zone.parse("2012-7-1 00:00:00")
      next_week = Work.make :start => Time.zone.parse("2012-7-8 00:00:00")
      LineItem.on_week(Time.zone.parse("2012-7-7 23:59:59")).should == [this_week]
    end
  end

  describe ".on_month" do
    it "filters out line items not on supplied date's month" do
      last_month = Work.make :start => Time.zone.parse("2012-6-30 23:59:59")
      this_month = Work.make :start => Time.zone.parse("2012-7-1 00:00:00")
      next_month = Work.make :start => Time.zone.parse("2012-8-1 00:00:00")
      LineItem.on_month(Time.zone.parse("2012-7-31 23:59:59")).should == [this_month]
    end
  end

  describe ".on_year" do
    it "filters out line items not on supplied date's year" do
      last_year = Work.make :start => Time.zone.parse("2011-12-31 23:59:59")
      this_year = Work.make :start => Time.zone.parse("2012-6-1 00:00:00")
      next_year = Work.make :start => Time.zone.parse("2013-1-1 00:00:00")
      LineItem.on_year(Time.zone.parse("2012-12-31 23:59:59")).should == [this_year]
    end
  end

  it "should be able to set the total manually" do
    @line_item = Work.make
    @line_item.total = 200
    @line_item.total.should == 200
  end
  
  it "should be able to set user name manually" do
    @line_item = Work.make
    @user = User.make
    @line_item.user_name = @user.name
    @line_item.user.should eql @user
  end
  
  it "should return invoice total if billed" do
    @invoice = Invoice.make
    @billed = Work.make :invoice => @invoice
    @billed.invoice_total.should eql @invoice.total
  end
  
  it "should return client balance if unbilled" do
    @client = Client.make
    @unbilled = Work.make :client => @client, :invoice => nil
    @unbilled.invoice_total.should eql @client.balance
  end
end
