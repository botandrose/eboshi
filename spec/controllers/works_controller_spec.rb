require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe WorksController do
  include ControllerSpecHelpers

  before :each do
    @client = FactoryBot.create :client
    @client.users << @current_user
    @work = FactoryBot.create :work, client: @client, user: @current_user
  end

  describe "should not error out" do
    it "on new" do
      get :new, params: { client_id: @client.id }
      response.should be_successful
    end
    it "on edit" do
      get :edit, params: { client_id: @client.id, id: @work.id }
      response.should be_successful
    end

    it "on create" do
      post :create, params: { client_id: @client.id, work: FactoryBot.attributes_for(:work) }
      response.should be_redirect
    end

    it "on update" do
      put :update, params: { client_id: @client.id, id: @work.id, work: FactoryBot.attributes_for(:work) }
      response.should be_redirect
    end
    it "on js update" do
      put :update, params: { client_id: @client.id, id: @work.id, work: FactoryBot.attributes_for(:work), format: 'js' }, xhr: true
      response.should be_successful
    end

    it "on shallow update" do
      put :update, params: { id: @work.id, work: FactoryBot.attributes_for(:work) }
      response.should be_redirect
    end
    it "on js shallow update" do
      put :update, params: { id: @work.id, work: FactoryBot.attributes_for(:work), format: 'js' }, xhr: true
      response.should be_successful
    end

    it "on destroy" do
      delete :destroy, params: { client_id: @client.id, id: @work.id }
      response.should be_redirect
    end
    it "on js destroy" do
      delete :destroy, params: { client_id: @client.id, id: @work.id, format: 'js' }, xhr: true
      response.should be_successful
    end

    it "on clock_in" do
      get :clock_in, params: { client_id: @client.id }
      response.should be_redirect
    end
    it "on js clock_in" do
      get :clock_in, params: { client_id: @client.id, format: 'js' }, xhr: true
      response.should be_successful
    end

    it "on clock_out" do
      @work = FactoryBot.create(:work, start: Time.zone.today, finish: Time.zone.today)
      get :clock_out, params: { client_id: @client.id, id: @work.id }
      response.should be_redirect
    end
    it "on js clock_out" do
      @work = FactoryBot.create(:work, start: Time.zone.today, finish: Time.zone.today)
      get :clock_out, params: { client_id: @client.id, id: @work.id, format: 'js' }, xhr: true
      response.should be_successful
    end
    it "on merge" do
      get :merge, params: { client_id: @client.id, line_item_ids: @client.works.collect(&:id) }
      response.should be_redirect
    end

    it "on js merge" do
      get :merge, params: { client_id: @client.id, line_item_ids: @client.works.collect(&:id), format: 'js' }, xhr: true
      response.should be_successful
    end
  end

  describe "on update" do
    it "should allow update of notes" do
      put :update, params: { id: @work.id, work: { notes: 'test' } }
      assigns(:work).errors.should be_empty
      assigns(:work).notes.should == 'test'
      response.should be_redirect
    end
  end
end
