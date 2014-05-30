module ControllerSpecHelpers
  def self.included(klass)
    klass.instance_eval do
      # integrate_views
      
      before :each do
        @current_user = FactoryGirl.create(:user, name: "Micah", business_name: "Micah Geisel")
        @current_user.stub authorized?: true
        controller.stub current_user: @current_user
      end
    end
  end
end

