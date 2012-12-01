class AdjustmentsController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  before_filter :filter_date, :only => [:create, :update]
  before_filter :filter_user, :only => [:create, :update]

  def new
    @adjustment = @client.adjustments.build
  end

  def create
    @adjustment = @client.adjustments.build params[:adjustment]
    if @adjustment.save
      flash[:notice] = "Adjustment successfully created."
      redirect_to invoices_path(@client)
    else
      render :new
    end
  end

  def edit
    get_adjustment
  end

  def update
    get_adjustment
    if @adjustment.update_attributes params[:adjustment]
      flash[:notice] = "Successfully updated Adjustment."
      respond_to do |wants|
        wants.html { redirect_to invoices_path(@client) }
        wants.js { render :nothing => true }
      end
    else
      render :edit
    end
  end

  def destroy
    get_adjustment
    @adjustment.destroy
    respond_to do |wants|
      wants.html { redirect_to invoices_path(@client) }
      wants.js { render :json => @adjustment.invoice_total }
    end
  end

  private
    def filter_date
      a = params[:adjustment]
      if a.delete(:no_date) == "1"
        a[:start] = nil 
        a.delete_if { |key, value| key =~ /^start\(.i\)$/ }
      end
    end

    def filter_user
      a = params[:adjustment]
      a[:user_id] = current_user.id if a[:user_id].blank?
      a[:user_id] = nil if a.delete(:no_user) == "1"
    end

    def get_adjustment
      @adjustment ||= Adjustment.find params[:id]
    end

    def get_client
      @client = params[:client_id] ? Client.find(params[:client_id]) : get_adjustment.client
    end

    def authorized?
      current_user.authorized? @client
    end
end
