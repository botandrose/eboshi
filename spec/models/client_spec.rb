require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Client do
  before do
    @client = FactoryGirl.create(:client)
    @invoice = FactoryGirl.create(:invoice, client: @client)
    @user = FactoryGirl.create(:user, rate: 65)
    @unbilled = [
      FactoryGirl.create(:work, :client => @client, :user => @user, :invoice => nil, start: Time.zone.now),
      FactoryGirl.create(:work, :client => @client, :user => @user, :invoice => nil, start: Time.zone.yesterday)
    ]
    FactoryGirl.create(:work, :client => @client, :user => @user, :invoice => @invoice)
    Payment.create(:invoice => @invoice, :total => 50)
    FactoryGirl.create(:adjustment, :client => @client, :user => @user, :invoice => @invoice, :rate => 100)
  end

  it "should order the building invoice before the saved invoices" do
    @it = @client.invoices_with_unbilled
    @it.length.should == 2
    @it.first.line_items.should == @unbilled
    @it.second.should == @invoice
  end

  it "should leave no trace when destroyed" do
    @client.destroy
    Invoice.count.should == 0
    Work.count.should == 0
    LineItem.count.should == 0
    Adjustment.count.should == 0    
    Payment.count.should == 0
  end

  it "should create a new instance given valid attributes" do
    Client.create! FactoryGirl.attributes_for(:client)
  end

  it "should calculate the total balance correctly" do
    @client.balance.should eql 200.0
  end

  it "should calculate the unbilled balance correctly" do
    @client.unbilled_balance.should eql 100.0
  end

  it "should calculate the overdue balance correctly" do
    @client.overdue_balance.should eql 100.0
  end

  it "should calculate the credits correctly" do
    @client.credits.should == 250
  end

  it "should calculate the debits correctly" do
    @client.debits.should == 50
  end

  it "should return a incomplete work item on clock_in" do
    li = @client.clock_in(@user)
    li.class.should == Work
    li.incomplete?.should be_truthy
  end

  it "should return an unsaved invoice with all unbilled line items" do
    i = @client.build_invoice_from_unbilled
    i.new_record?.should be_truthy
    i.line_items.should == @unbilled
  end
end
