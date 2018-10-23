class AssignmentsController < ApplicationController
  def new
    @client = current_user.clients.find params[:client_id]
    @assignment = @client.assignments.build user: current_user
  end

  def create
    @client = current_user.clients.find params[:client_id]
    user = User.find_by_id(params[:assignment][:user_id]) || User.find_by_email(params[:assignment][:email])
    if user
      @client.users << user
      redirect_to invoices_path(@client), notice: "Successfully created!"
    else
      redirect_to new_assignment_path(@client), alert: "A user with that email address does not exist!"
    end
  end

  def destroy
    @assignment = Assignment.find params[:id]
    raise ActiveRecord::RecordNotFound unless current_user.clients.include? @assignment.client
    @assignment.destroy
    if @assignment.user == current_user
      redirect_to "/"
    else
      redirect_back fallback_location: "/"
    end
  end
end
