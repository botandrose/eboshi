require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AdjustmentsController do
  include ControllerSpecHelpers

  before :each do
    @client = FactoryBot.create :client
    @adjustment = FactoryBot.create :adjustment, client: @client
  end

  describe "should not error out" do
    it "on edit" do
      get :edit, client_id: @client.id, id: @adjustment.id
      response.should be_success
    end
    it "on new" do
      get :new, client_id: @client.id
      response.should be_success
    end

    it "on create" do
      post :create, client_id: @client.id, adjustment: FactoryBot.attributes_for(:adjustment)
      response.should be_redirect
    end

    it "on update" do
      put :update, client_id: @client.id, id: @adjustment.id, adjustment: FactoryBot.attributes_for(:adjustment)
      response.should be_redirect
    end
    it "on js update" do
      put :update, client_id: @client.id, id: @adjustment.id, adjustment: FactoryBot.attributes_for(:adjustment), format: 'js'
      response.should be_success
    end

    it "on shallow update" do
      put :update, id: @adjustment.id, adjustment: FactoryBot.attributes_for(:adjustment)
      response.should be_redirect
    end
    it "on js shallow update" do
      put :update, id:  @adjustment.id, adjustment: FactoryBot.attributes_for(:adjustment), format: 'js'
      response.should be_success
    end

    it "on destroy" do
      delete :destroy, client_id: @client.id, id: @adjustment.id
      response.should be_redirect
    end
    it "on js destroy" do
      delete :destroy, client_id: @client.id, id: @adjustment.id, format: 'js'
      response.should be_success
    end
  end

  describe "on update" do
    it "should allow update of notes" do
      put :update, id: @adjustment.id, adjustment: { notes: 'test' }
      assigns(:adjustment).errors.should be_empty
      assigns(:adjustment).notes.should == 'test'
      response.should be_redirect
    end
  end
end
