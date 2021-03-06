require "spec_helper"

describe LineItem do
  describe ".unbilled" do
    it "excludes billed line items" do
      unbilled = FactoryBot.create :work, invoice: nil
      billed = FactoryBot.create :work, invoice: FactoryBot.create(:invoice)
      LineItem.unbilled.should == [unbilled]
    end
  end

  describe ".on_date" do
    it "filters out line items not on supplied date" do
      yesterday = FactoryBot.create :work, start: Time.zone.parse("2012-6-30 23:59:59")
      today = FactoryBot.create :work, start: Time.zone.parse("2012-7-1 00:00:00")
      tomorrow = FactoryBot.create :work, start: Time.zone.parse("2012-7-2 00:00:00")
      LineItem.on_date(Time.zone.parse("2012-7-1 23:59:59")).should == [today]
    end
  end

  describe ".on_week" do
    it "filters out line items not on supplied date's week" do
      # 2012-7-1 is a sunday
      last_week = FactoryBot.create :work, start: Time.zone.parse("2012-6-30 23:59:59")
      this_week = FactoryBot.create :work, start: Time.zone.parse("2012-7-1 00:00:00")
      next_week = FactoryBot.create :work, start: Time.zone.parse("2012-7-8 00:00:00")
      LineItem.on_week(Time.zone.parse("2012-7-7 23:59:59")).should == [this_week]
    end
  end

  describe ".on_month" do
    it "filters out line items not on supplied date's month" do
      last_month = FactoryBot.create :work, start: Time.zone.parse("2012-6-30 23:59:59")
      this_month = FactoryBot.create :work, start: Time.zone.parse("2012-7-1 00:00:00")
      next_month = FactoryBot.create :work, start: Time.zone.parse("2012-8-1 00:00:00")
      LineItem.on_month(Time.zone.parse("2012-7-31 23:59:59")).should == [this_month]
    end
  end

  describe ".on_year" do
    it "filters out line items not on supplied date's year" do
      last_year = FactoryBot.create :work, start: Time.zone.parse("2011-12-31 23:59:59")
      this_year = FactoryBot.create :work, start: Time.zone.parse("2012-6-1 00:00:00")
      next_year = FactoryBot.create :work, start: Time.zone.parse("2013-1-1 00:00:00")
      LineItem.on_year(Time.zone.parse("2012-12-31 23:59:59")).should == [this_year]
    end
  end

  it "should be able to set the total manually" do
    @line_item = FactoryBot.create :work
    @line_item.total = 200
    @line_item.total.should == 200
  end

  it "should be able to set user name manually" do
    @line_item = FactoryBot.create(:work)
    @user = FactoryBot.create(:user)
    @line_item.user_name = @user.name
    @line_item.user.should eql @user
  end

  it "should return invoice total if billed" do
    @invoice = FactoryBot.create(:invoice)
    @billed = FactoryBot.create(:work, invoice: @invoice)
    @billed.invoice_total.should eql @invoice.total
  end

  it "should return client balance if unbilled" do
    @client = FactoryBot.create(:client)
    @unbilled = FactoryBot.create(:work, client: @client, invoice: nil)
    @unbilled.invoice_total.should eql @client.balance
  end
end
