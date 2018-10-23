require "spec_helper"

describe ClientsController do
  include ControllerSpecHelpers

  before(:each) do
    @client = FactoryBot.create(:client)
    @client.users << @current_user
  end

  describe "should not error out" do
    it "on index" do
      get :index
    end
    it "on edit" do
      get :edit, params: { id: @client.id }
    end
    it "on new" do
      get :new
    end
    it "on update" do
      put :update, params: { id: @client.id, client: FactoryBot.attributes_for(:client) }
    end
    it "on destroy" do
      delete :destroy, params: { id: @client.id }
    end
    it "on create" do
      post :create, params: { client: FactoryBot.attributes_for(:client) }
    end
  end
end
