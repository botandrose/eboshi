require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe User do
  it "should return a default rate for a client" do
    @user = FactoryGirl.create(:user)
    @client = FactoryGirl.create(:client)
    FactoryGirl.create :work, client: @client, rate: 60, start: Time.zone.today.midnight - 2.days, user: @user
    FactoryGirl.create :work, client: @client, rate: 70, start: Time.zone.today.midnight + 1.days, user: @user
    FactoryGirl.create :work, client: @client, rate: 50, start: Time.zone.today.midnight - 1.days, user: @user
    FactoryGirl.create :work, client: @client, rate: 100, start: Time.zone.today.midnight + 2.days, user: FactoryGirl.create(:user)
    FactoryGirl.create :work, client: FactoryGirl.create(:client), rate: 120, start: Time.zone.today.midnight + 3.days, user: @user
    @user.default_rate_for(@client).should == 70
  end

  describe "related_users" do
    it "should return all users that share clients" do
      @client = FactoryGirl.create(:client)
      @it = FactoryGirl.create(:user)

      @client.users << @it
      3.times { @client.users << FactoryGirl.create(:user) }
      2.times { FactoryGirl.create(:user) }

      @it.related_users.length.should == 3
    end
  end

  describe "totals by date" do
    before do
      @it = FactoryGirl.create(:user)
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.zone.today.midnight + 1.year, finish: Time.zone.today.midnight + 1.hour + 1.year
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.zone.today.midnight + 1.month, finish: Time.zone.today.midnight + 1.hour + 1.month
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.zone.today.midnight + 1.week, finish: Time.zone.today.midnight + 1.hour + 1.week

      FactoryGirl.create :work, user: @it, rate: 60, start: Time.zone.today.midnight, finish: Time.zone.today.midnight + 1.hour
      FactoryGirl.create :work, user: @it, rate: 70, start: Time.zone.today.midnight, finish: Time.zone.today.midnight + 1.hour
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.zone.today.midnight, finish: Time.zone.today.midnight + 1.hour
    end

    it "should return the total money earned", wip: true do
      @it.total_by_date(Time.zone.today.midnight).to_f.should == 180.0
    end

    it "should return the total hours" do
      @it.hours_by_date(Time.zone.today.midnight).to_f.should == 3.0
    end
  end

  describe "totals by week" do
    before do
      @it = FactoryGirl.create(:user)
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1982-06-15 12:00:00"), finish: Time.parse("1982-06-15 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1983-05-13 12:00:00"), finish: Time.parse("1983-05-13 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1983-06-07 12:00:00"), finish: Time.parse("1983-06-07 13:00:00")

      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1983-06-13 12:00:00"), finish: Time.parse("1983-06-13 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 70, start: Time.parse("1983-06-15 12:00:00"), finish: Time.parse("1983-06-15 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.parse("1983-06-17 12:00:00"), finish: Time.parse("1983-06-17 13:00:00")
    end

    it "should return the total money earned" do
      @it.total_by_week(Date.parse("1983-06-15")).should == 180.0
    end

    it "should return the total hours" do
      @it.hours_by_week(Date.parse("1983-06-15")).should == 3
    end
  end

  describe "totals by month" do
    before do
      @it = FactoryGirl.create(:user)
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1982-06-10 12:00:00"), finish: Time.parse("1982-06-10 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1983-05-15 12:00:00"), finish: Time.parse("1983-05-15 13:00:00")

      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1983-06-10 12:00:00"), finish: Time.parse("1983-06-10 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 70, start: Time.parse("1983-06-11 12:00:00"), finish: Time.parse("1983-06-11 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.parse("1983-06-12 12:00:00"), finish: Time.parse("1983-06-12 13:00:00")
    end

    it "should return the total money earned" do
      @it.total_by_month(Date.parse("1983-06-19")).should == 180.0
    end

    it "should return the total hours" do
      @it.hours_by_month(Date.parse("1983-06-19")).should == 3
    end
  end

  describe "totals by year" do
    before do
      @it = FactoryGirl.create(:user)
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1982-06-10 12:00:00"), finish: Time.parse("1982-03-10 13:00:00")

      FactoryGirl.create :work, user: @it, rate: 60, start: Time.parse("1983-03-10 12:00:00"), finish: Time.parse("1983-03-10 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 70, start: Time.parse("1983-06-11 12:00:00"), finish: Time.parse("1983-06-11 13:00:00")
      FactoryGirl.create :work, user: @it, rate: 50, start: Time.parse("1983-09-12 12:00:00"), finish: Time.parse("1983-09-12 13:00:00")
    end

    it "should return the total money earned" do
      @it.total_by_year(Date.parse("1983-06-19")).should == 180.0
    end

    it "should return the total hours" do
      @it.hours_by_year(Date.parse("1983-06-19")).should == 3
    end
  end

  describe "shouldnt fuck up when encountering times without zones" do
    before do
      @it = FactoryGirl.create(:user)
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.zone.parse("1983-12-31 22:00:00"), finish: Time.zone.parse("1984-01-01 00:00:00")
    end

    it "on total by date" do
      @it.total_by_date(Date.parse("1983-12-31")).should == 120.0
    end

    it "on hours by date" do
      @it.hours_by_date(Date.parse("1983-12-31")).should == 2
    end

    it "on total by month" do
      @it.total_by_month(Date.parse("1983-12-19")).should == 120.0
    end

    it "on hours by month" do
      @it.hours_by_month(Date.parse("1983-12-19")).should == 2
    end
  end

  describe "shouldnt fuck up when encountering times with zones" do
    before do
      @it = FactoryGirl.create(:user)
      FactoryGirl.create :work, user: @it, rate: 60, start: Time.zone.parse("1983-01-01 02:00:00"), finish: Time.zone.parse("1983-01-01 04:00:00")
    end

    it "on total by date" do
      @it.total_by_date(Time.zone.parse("1983-01-01")).should == 120.0
    end

    it "on hours by date" do
      @it.hours_by_date(Time.zone.parse("1983-01-01")).should == 2
    end

    it "on total by month" do
      @it.total_by_month(Time.zone.parse("1983-01-19")).should == 120.0
    end

    it "on hours by month" do
      @it.hours_by_month(Time.zone.parse("1983-01-19")).should == 2
    end
  end
end
