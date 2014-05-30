class ClientsController < ApplicationController
  def index
    @clients = current_user.clients
  end

  def new
    @client = Client.new
  end

  def edit
    @client = current_user.clients.find(params[:id])
  end

  def create
    @client = Client.new(params[:client])
    if @client.save
      @client.users << current_user
      redirect_to clients_path, notice: "Client successfully created."
    else
      render :new
    end
  end
  
  def update
    @client = current_user.clients.find(params[:id])
    if @client.update_attributes(params[:client])
      redirect_to clients_path, notice: "Client successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @client = current_user.clients.find params[:id]
    @client.destroy
    redirect_to clients_path
  end
end

