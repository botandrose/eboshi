require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invoice do
  describe "consistant_rate" do
    it "should return false if invoice contains work items with varying hourly rates" do
      @it = Invoice.make
      Work.make :invoice => @it, :rate => 50
      Work.make :invoice => @it, :rate => 75
      @it.consistant_rate.should be_false
    end

    it "should return the rate if invoice contains work items with the same hourly rates" do
      @it = Invoice.make
      3.times { Work.make :invoice => @it, :rate => 75 }
      @it.consistant_rate.should == 75 
    end

    it "should return true if invoice contains no work items" do
      @it = Invoice.make
      @it.consistant_rate.should be_true
    end
  end

  it "should create a new instance given valid attributes" do
    Invoice.create! Invoice.make.attributes
  end

  it "should not be paid if there are no payments" do
    @invoice = Invoice.make
    2.times do
      work = Work.make :invoice => @invoice, :rate => 50
      work.update_attribute(:total, 100)
    end
    @invoice.should_not be_paid
  end

  it "should calculate total as sum of line items" do
    @invoice = Invoice.make
    2.times do
      work = Work.make :invoice => @invoice, :rate => 50
      work.update_attribute(:total, 100)
    end
    @invoice.total.should == 200
  end

  it "should calculate balance as sum of line items minus sum of payments" do
    @invoice = Invoice.make
    2.times do
      work = Work.make :invoice => @invoice, :rate => 50
      work.update_attribute(:total, 100)
    end
    @invoice.payments.create(:total => 100)
    @invoice.balance.should == 100
  end

  it "unpaid scope should return unpaid invoices and partially paid invoices" do
    @client = Client.make

    @unpaid = @client.invoices.make
    Work.make :invoice => @unpaid

    @partpaid = @client.invoices.make
    Work.make :invoice => @partpaid
    @partpaid.payments.make :total => 25

    @paid = @client.invoices.make
    Work.make :invoice => @paid
    @paid.payments.make :total => 50

    Invoice.unpaid.should have(2).invoices
    Invoice.unpaid.should include(@unpaid, @partpaid)
    Invoice.unpaid.should_not include(@paid)
  end

  it "should default date and paid to false" do
    @invoice = Invoice.new
    @invoice.date.should eql Time.zone.today.midnight
    @invoice.should_not be_paid
  end

  it "should create an adjustment item when a total is assigned that doesnt equal the sum of the line items" do
    @invoice = Invoice.make
    count = @invoice.adjustments.length
    @invoice.total += 50
    @invoice.adjustments.length.should eql count+1
    @invoice.adjustments.last.total.should eql 50
  end

  it "should handle the total attribute through mass assignment" do
    @invoice = Invoice.make
    5.times { Work.make :invoice => @invoice }
    total = @invoice.total
    @invoice.attributes = { :total => total-50 }
    @invoice.save
    @invoice.reload.total.should == total-50
  end

  it "should not create an adjustment item when a total is assigned that equals the sum of the line items" do
    @invoice = Invoice.make
    count = @invoice.adjustments.length
    @invoice.total = @invoice.total
    @invoice.adjustments.length.should eql count
  end

end
