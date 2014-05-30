require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WorksController do
  include ControllerSpecHelpers

  before :each do
    @client = FactoryGirl.create :client
    @client.users << @current_user
    @work = FactoryGirl.create :work, client: @client, user: @current_user
  end

  describe "should not error out" do
    it "on new" do
      get :new, :client_id => @client.id
      response.should be_success
    end
    it "on edit" do
      get :edit, :client_id => @client.id, :id => @work.id
      response.should be_success
    end

    it "on create" do
      post :create, client_id: @client.id, work: FactoryGirl.attributes_for(:work)
      response.should be_redirect
    end

    it "on update" do
      put :update, client_id: @client.id, id: @work.id, work: FactoryGirl.attributes_for(:work)
      response.should be_redirect
    end
    it "on js update" do
      put :update, client_id: @client.id, id: @work.id, work: FactoryGirl.attributes_for(:work), format: 'js'
      response.should be_success
    end

    it "on shallow update" do
      put :update, id: @work.id, work: FactoryGirl.attributes_for(:work)
      response.should be_redirect
    end
    it "on js shallow update" do
      put :update, id: @work.id, work: FactoryGirl.attributes_for(:work), format: 'js'
      response.should be_success
    end

    it "on destroy" do
      delete :destroy, :client_id => @client.id, :id => @work.id
      response.should be_redirect
    end
    it "on js destroy" do
      delete :destroy, :client_id => @client.id, :id => @work.id, :format => 'js'
      response.should be_success
    end

    it "on clock_in" do
      get :clock_in, :client_id => @client.id
      response.should be_redirect
    end
    it "on js clock_in" do
      get :clock_in, :client_id => @client.id, :format => 'js'
      response.should be_success
    end

    it "on clock_out" do
      @work = FactoryGirl.create(:work, start: Time.zone.today, finish: Time.zone.today)
      get :clock_out, :client_id => @client.id, :id => @work.id
      response.should be_redirect
    end
    it "on js clock_out" do
      @work = FactoryGirl.create(:work, start: Time.zone.today, finish: Time.zone.today)
      get :clock_out, :client_id => @client.id, :id => @work.id, :format => 'js'
      response.should be_success
    end
    it "on merge" do
      get :merge, :client_id => @client.id, :line_item_ids => @client.works.collect(&:id)
      response.should be_redirect
    end  	
    
    it "on js merge" do
      get :merge, :client_id => @client.id, :line_item_ids => @client.works.collect(&:id), :format => 'js'
      response.should be_success
    end  	
  end

  describe "on update" do
    it "should allow update of notes" do
      put :update, :id => @work.id, :work => { :notes => 'test' }
      assigns(:work).should have(:no).errors 
      assigns(:work).notes.should == 'test'
      response.should be_redirect
    end
  end
end
