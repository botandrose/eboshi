require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvoicesController do
  include ControllerSpecHelpers

  describe "should not error out" do
    before :each do
      @client = Client.make
      @invoice = @client.invoices.make
      Work.make :invoice => @invoice, :client => @client, :user => @current_user
      Adjustment.make :invoice => @invoice, :client => @client
    end

    it "on index" do
      get :index, :client_id => @client.id
      response.should be_success
    end
    it "on new" do
      get :new, :client_id => @client.id
      response.should be_success
    end

    it "on show" do
      get :show, :format => "pdf", :client_id => @client.id, :id => @invoice.id
      response.should be_success
    end
    it "on js show" do
      get :show, :client_id => @client.id, :id => @invoice.id, :format => 'js'
      response.should be_success
    end

    it "on edit" do
      get :edit, :client_id => @client.id, :id => @invoice.id
      response.should be_success
    end
    it "on js edit" do
      get :edit, :client_id => @client.id, :id => @invoice.id, :format => 'js'
      response.should be_success
    end

    it "on create" do
      post :create, :client_id => @client.id, :client_id => @client.id, :invoice => @invoice.attributes
      response.should be_redirect
    end
    it "on update" do
      put :update, :client_id => @client.id, :id => @invoice.id, :invoice => @invoice.attributes
      response.should be_redirect
    end
    it "on destroy" do
      delete :destroy, :client_id => @client.id, :id => @invoice.id
      response.should be_redirect
    end
  end

  it "should name the pdf correctly" do
    @client = Client.make
    @invoice = @client.invoices.make :id => 123
    Work.make :invoice => @invoice, :client => @client, :user => @current_user
    Adjustment.make :invoice => @invoice, :client => @client

    get :show, :client_id => @client.id, :id => @invoice.id, :format => 'pdf'

    response.headers["Content-Disposition"].should =~ /micah-geisel_invoice-\#123\.pdf/
    response.should be_success
  end

end
