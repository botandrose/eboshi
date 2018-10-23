require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Adjustment do
  before(:each) do
    @adjustment = FactoryBot.create(:adjustment)
  end

  it "should not have any hours" do
    @adjustment.hours.should eql 0
  end

  it "should calculate the total correctly" do
    @adjustment.rate = -25
    @adjustment.total.should eql -25
  end

  it "should not be checked" do
    @adjustment.checked?.should be_falsey
  end

  it "should respond via total" do
    @adjustment = Adjustment.new total: 50
    @adjustment.total.should eql 50
  end
end
