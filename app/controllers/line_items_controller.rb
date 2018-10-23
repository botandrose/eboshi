class LineItemsController < ApplicationController
  before_action :get_client
  before_action :authorized?

  def update
    line_item = LineItem.find(params[:id])
    if line_item.timestamp < params[:line_item][:timestamp].to_i
      line_item.update_attributes(params[:line_item])
    end
    head :ok
  end

  private

  def get_client
    @client ||= (@line_item.try(:client) || Client.find(params[:client_id]))
  end

  def authorized?
    current_user.authorized? @client
  end
end
