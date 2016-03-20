require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AssignmentsController do
  include ControllerSpecHelpers

  it "should raise a 404 when trying to destroy an unassigned clients assignment" do
    controller.stub current_user: FactoryGirl.create(:user)
    @it = Assignment.create! client: FactoryGirl.create(:client), user: FactoryGirl.create(:user)
    -> { delete :destroy, id: @it.id }.should raise_error ActiveRecord::RecordNotFound
  end
end
