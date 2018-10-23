require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UsersController do
  include ControllerSpecHelpers

  before(:each) do
    @user = FactoryBot.create :user
  end

  describe "should not error out" do
    it "on index" do
      admin = FactoryBot.create :user, admin: true
      controller.stub current_user: admin
      get :index
    end
    it "on edit" do
      get :edit, params: { id: @user.id }
    end
    it "on new" do
      get :new
    end
    it "on update" do
      put :update, params: { id: @user.id, user: @user.attributes }
    end
    it "on create" do
      post :create, params: { user: @user.attributes }
    end
  end
end
