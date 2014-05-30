require "spec_helper"

describe ClientsController do
  include ControllerSpecHelpers
  
	before(:each) do
		@client = FactoryGirl.create(:client)
    @client.users << @current_user
	end

  describe "should not error out" do
    it "on index" do
      get :index
    end
    it "on edit" do
      get :edit, id: @client.id
    end
    it "on new" do
      get :new
    end
    it "on update" do
      put :update, id: @client.id, client: FactoryGirl.attributes_for(:client)
    end
    it "on destroy" do
      delete :destroy, id: @client.id
    end
    it "on create" do
      post :create, client: FactoryGirl.attributes_for(:client)
    end
  end
end

