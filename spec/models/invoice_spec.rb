require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invoice do
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
    @unpaid = Invoice.make
    3.times { Work.make :invoice => @unpaid }
    
    @partpaid = Invoice.make
    3.times { Work.make :invoice => @partpaid }
    @partpaid.payments << Payment.new(:total => 50)
    
    @paid = Invoice.make
    3.times do
      Work.make :invoice => @paid
      @paid.payments << Payment.new(:total => 50)
    end
    
    Invoice.unpaid.should have(2).invoices
    Invoice.unpaid.should include(@unpaid, @partpaid)
    Invoice.unpaid.should_not include(@paid)
  end
  
  it "should default date and paid to false" do
  	@invoice = Invoice.new
  	@invoice.date.should eql Time.today
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
    5.times { @invoice.works.create! Work.make.attributes }
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
