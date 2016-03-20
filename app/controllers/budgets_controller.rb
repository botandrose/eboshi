class BudgetsController < ApplicationController
  before_filter :get_client, :authorized?

  def new
    @budget = @client.budgets.build
    render :form
  end

  def create
    @budget = @client.budgets.build(params[:budget])
    @budget.save!
    redirect_to [@client, :invoices], notice: "Budget created"
  end

  def edit
    @budget = @client.budgets.find(params[:id])
    render :form
  end

  def update
    @budget = @client.budgets.find(params[:id])
    @budget.update_attributes!(params[:budget])
    redirect_to [@client, :invoices], notice: "Budget updated"
  end

  private

  def get_client
    @client = Client.find(params[:client_id])
  end

  def authorized?
    current_user.authorized?(@client)
  end
end

