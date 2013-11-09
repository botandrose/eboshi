require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserSessionsController do
  include ControllerSpecHelpers
  
  describe "should not error out" do
    it "on new" do
    	get :new
		end

		it "on create" do
			User.stub authenticate: User.make
			post :create
		end

		it "on destroy" do
      session = double.as_null_object
		  controller.stub current_user_session: session
			get :destroy
		end
  end
end

