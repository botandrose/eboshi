require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvoicesController do
  include ControllerSpecHelpers

  describe "should not error out" do
    before :each do
      @client = FactoryBot.create :client
      @invoice = FactoryBot.create :invoice, client: @client
      FactoryBot.create :work, invoice: @invoice, client: @client, user: @current_user
      FactoryBot.create :adjustment, invoice: @invoice, client: @client
    end

    it "on index" do
      get :index, client_id: @client.id
      response.should be_success
    end
    it "on new" do
      get :new, client_id: @client.id
      response.should be_success
    end

    # it "on show" do
    #   get :show, :format => "pdf", :client_id => @client.id, :id => @invoice.id
    #   response.should be_success
    # end

    it "on js show" do
      xhr :get, :show, client_id: @client.id, id: @invoice.id, format: 'js'
      response.should be_success
    end

    it "on edit" do
      get :edit, client_id: @client.id, id: @invoice.id
      response.should be_success
    end
    it "on js edit" do
      xhr :get, :edit, client_id: @client.id, id: @invoice.id, format: 'js'
      response.should be_success
    end

    it "on create" do
      post :create, client_id: @client.id, invoice: FactoryBot.attributes_for(:invoice)
      response.should be_redirect
    end
    it "on js update" do
      xhr :put, :update, client_id: @client.id, id: @invoice.id, invoice: FactoryBot.attributes_for(:invoice), format: "js"
      response.should be_redirect
    end
    it "on destroy" do
      delete :destroy, client_id: @client.id, id: @invoice.id
      response.should be_redirect
    end
  end

  # it "should name the pdf correctly" do
  #   @client = FactoryBot.create :client
  #   @invoice = FactoryBot.create :invoice, client: @client, id: 123
  #   FactoryBot.create :work, invoice: @invoice, client: @client, user: @current_user
  #   FactoryBot.create :adjustment, invoice: @invoice, client: @client

  #   get :show, :client_id => @client.id, :id => @invoice.id, :format => 'pdf'

  #   response.headers["Content-Disposition"].should =~ /micah-geisel_invoice-\#123\.pdf/
  #   response.should be_success
  # end
end
