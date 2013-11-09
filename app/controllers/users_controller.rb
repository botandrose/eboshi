class UsersController < ApplicationController
  def index
    require_admin
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new params[:user]
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes params[:user]
      flash[:notice] = "Account updated!"
      redirect_to_last_client_or_back_or_default
    else
      render :edit
    end
  end
end
