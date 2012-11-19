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
      yesterday = Work.make :start => Time.zone.parse("6/30/2012 23:59:59")
      today = Work.make :start => Time.zone.parse("7/1/2012 00:00:00")
      tomorrow = Work.make :start => Time.zone.parse("7/2/2012 00:00:00")
      LineItem.on_date(Time.zone.parse("7/1/2012 23:59:59")).should == [today]
    end
  end

  describe ".on_week" do
    it "filters out line items not on supplied date's week" do
      # 7/1/2012 is a sunday
      last_week = Work.make :start => Time.zone.parse("6/30/2012 23:59:59")
      this_week = Work.make :start => Time.zone.parse("7/1/2012 00:00:00")
      next_week = Work.make :start => Time.zone.parse("7/8/2012 00:00:00")
      LineItem.on_week(Time.zone.parse("7/7/2012 23:59:59")).should == [this_week]
    end
  end

  describe ".on_month" do
    it "filters out line items not on supplied date's month" do
      last_month = Work.make :start => Time.zone.parse("6/30/2012 23:59:59")
      this_month = Work.make :start => Time.zone.parse("7/1/2012 00:00:00")
      next_month = Work.make :start => Time.zone.parse("8/1/2012 00:00:00")
      LineItem.on_month(Time.zone.parse("7/31/2012 23:59:59")).should == [this_month]
    end
  end

  describe ".on_year" do
    it "filters out line items not on supplied date's year" do
      last_year = Work.make :start => Time.zone.parse("12/31/2011 23:59:59")
      this_year = Work.make :start => Time.zone.parse("6/1/2012 00:00:00")
      next_year = Work.make :start => Time.zone.parse("1/1/2013 00:00:00")
      LineItem.on_year(Time.zone.parse("12/31/2012 23:59:59")).should == [this_year]
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
