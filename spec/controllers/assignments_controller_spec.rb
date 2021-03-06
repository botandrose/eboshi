require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AssignmentsController do
  include ControllerSpecHelpers

  it "should raise a 404 when trying to destroy an unassigned clients assignment" do
    controller.stub current_user: FactoryBot.create(:user)
    @it = Assignment.create! client: FactoryBot.create(:client), user: FactoryBot.create(:user)
    expect do
      delete :destroy, params: { id: @it.id }
    end.to raise_error(ActiveRecord::RecordNotFound)
  end
end
