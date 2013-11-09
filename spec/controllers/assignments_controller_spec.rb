require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AssignmentsController do
  include ControllerSpecHelpers
  
  it "should raise a 404 when trying to destroy an unassigned clients assignment" do
    controller.stub current_user: User.make
		@it = Assignment.create! :client => Client.make, :user => User.make
    lambda { delete :destroy, :id => @it.id }.should raise_error ActiveRecord::RecordNotFound
  end

end
