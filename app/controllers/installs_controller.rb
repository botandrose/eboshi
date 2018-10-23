class InstallsController < ApplicationController
  skip_before_action :autoinstall, :require_user

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    @user.admin = true
    if @user.save
      UserSession.create(@user)
    else
      render :new
    end
  end
end
