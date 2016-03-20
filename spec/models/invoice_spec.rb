require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invoice do
  subject { FactoryGirl.create(:invoice) }

  describe "consistant_rate" do
    it "should return false if invoice contains work items with varying hourly rates" do
      @it = FactoryGirl.create(:invoice)
      FactoryGirl.create(:work, invoice: @it, rate: 50)
      FactoryGirl.create(:work, invoice: @it, rate: 75)
      @it.consistant_rate.should be_falsey
    end

    it "should return the rate if invoice contains work items with the same hourly rates" do
      @it = FactoryGirl.create(:invoice)
      3.times { FactoryGirl.create(:work, invoice: @it, rate: 75) }
      @it.consistant_rate.should == 75
    end

    it "should return true if invoice contains no work items" do
      @it = FactoryGirl.create(:invoice)
      @it.consistant_rate.should be_truthy
    end
  end

  it "should not be paid if there are no payments" do
    @invoice = FactoryGirl.create(:invoice)
    2.times do
      work = FactoryGirl.create(:work, invoice: @invoice, rate: 50)
      work.update_attribute(:total, 100)
    end
    @invoice.should_not be_paid
  end

  it "should calculate total as sum of line items" do
    @invoice = FactoryGirl.create(:invoice)
    2.times do
      work = FactoryGirl.create(:work, invoice: @invoice, rate: 50)
      work.update_attribute(:total, 100)
    end
    @invoice.total.should == 200
  end

  it "should calculate balance as sum of line items minus sum of payments" do
    @invoice = FactoryGirl.create(:invoice)
    2.times do
      work = FactoryGirl.create(:work, invoice: @invoice, rate: 50)
      work.update_attribute(:total, 100)
    end
    @invoice.payments.create(total: 100)
    @invoice.balance.should == 100
  end

  it "unpaid scope should return unpaid invoices and partially paid invoices" do
    @client = FactoryGirl.create(:client)

    @unpaid = FactoryGirl.create(:invoice, client: @client)
    FactoryGirl.create(:work, invoice: @unpaid)

    @partpaid = FactoryGirl.create(:invoice, client: @client)
    FactoryGirl.create(:work, invoice: @partpaid)
    FactoryGirl.create(:payment, invoice: @partpaid, total: 25)

    @paid = FactoryGirl.create(:invoice, client: @client)
    FactoryGirl.create(:work, invoice: @paid)
    FactoryGirl.create(:payment, invoice: @paid, total: 50)

    Invoice.unpaid.should =~ [@unpaid, @partpaid]
  end

  it "should default date and paid to false" do
    @invoice = Invoice.new
    @invoice.date.should eql Time.zone.today.midnight
    @invoice.should_not be_paid
  end

  it "should create an adjustment item when a total is assigned that doesnt equal the sum of the line items" do
    @invoice = FactoryGirl.create(:invoice)
    count = @invoice.adjustments.length
    @invoice.total += 50
    @invoice.adjustments.length.should eql count + 1
    @invoice.adjustments.last.total.should eql 50
  end

  it "should handle the total attribute through mass assignment" do
    @invoice = FactoryGirl.create(:invoice)
    5.times { FactoryGirl.create(:work, invoice: @invoice) }
    total = @invoice.total
    @invoice.attributes = { total: total - 50 }
    @invoice.save
    @invoice.reload.total.should == total - 50
  end

  it "should not create an adjustment item when a total is assigned that equals the sum of the line items" do
    @invoice = FactoryGirl.create(:invoice)
    count = @invoice.adjustments.length
    @invoice.total = @invoice.total
    @invoice.adjustments.length.should eql count
  end

  describe "#line_items_for_invoice" do
    it "groups line items with the same notes together" do
      FactoryGirl.create(:work, invoice: subject, total: 50, notes: "a")
      FactoryGirl.create(:work, invoice: subject, total: 50, notes: "a")
      FactoryGirl.create(:work, invoice: subject, total: 75, notes: "b")
      FactoryGirl.create(:work, invoice: subject, total: 50, notes: "a")

      subject.line_items_for_invoice.should == [
        OpenStruct.new(total: 150, notes: "a"),
        OpenStruct.new(total: 75, notes: "b"),
      ]
    end
  end
end
