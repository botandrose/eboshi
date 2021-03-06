require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PaymentsController do
  include ControllerSpecHelpers

  it "should not error out on new" do
    @client = FactoryBot.create :client
    @invoice = FactoryBot.create :invoice, client: @client
    get :new, params: { invoice_id: @invoice.id }
  end

  it "should add a payment to the invoice on create" do
    @invoice = FactoryBot.create :invoice
    @invoice.update_attribute :total, 500
    payment_attributes = {
      total: "50"
    }
    post :create, params: { invoice_id: @invoice.id, payment: payment_attributes }
    assigns(:invoice).balance.to_i.should == 450
  end
end
