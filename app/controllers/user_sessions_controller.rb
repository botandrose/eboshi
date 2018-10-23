class UserSessionsController < ApplicationController
  before_action :require_no_user, only: [:new, :create]
  before_action :require_user, only: :destroy

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session].to_h)
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_to_last_client_or_back_or_default
    else
      render "new"
    end
  end

  def destroy
    current_user_session.destroy
    redirect_to login_path, notice: "Logout successful!"
  end
end
