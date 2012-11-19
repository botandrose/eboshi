class LineItemsController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  def update
    @line_item = LineItem.find params[:id]
    if @line_item.update_attributes params[:line_item]
      flash[:notice] = "Line Item successfully updated!"
      render :nothing => true
    end
  end


  protected
    def get_client
      @client ||= (@line_item.try(:client) || Client.find(params[:client_id]))
    end

  private
    def authorized?
      current_user.authorized? @client
    end
end
