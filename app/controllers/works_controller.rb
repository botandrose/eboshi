class WorksController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  def new
    @work = @client.works.build :user => current_user
  end

  def create
    @work = @client.works.build params[:work].merge(:user => current_user)
    if @work.save
      flash[:notice] = "Successfully created Work."
      redirect_to invoices_path(@client)
    else
      render :new
    end
  end

  def edit
    @work = Work.find params[:id]
  end

  def update
    @work = Work.find params[:id]
    if @work.update_attributes params[:work]
      flash[:notice] = "Successfully updated Work."
      respond_to do |wants|
        wants.html { redirect_to invoices_path(@client) }
        wants.js { render :nothing => true }
      end
    else
      render :edit
    end
  end

  def destroy
    @work = Work.find params[:id]
    @work.destroy
    invoice = @work.invoice || @client.build_invoice_from_unbilled

    respond_to do |wants|
      wants.html { redirect_to invoices_path(@client) }
      wants.js { render :json => invoice.total }
    end
  end

  def clock_in
    @work = @client.clock_in current_user
    
    respond_to do |format|
      format.html { redirect_to invoices_path(@client) }
      format.js { render @work }
    end
  end
  
  def clock_out
    @work = Work.find params[:id]
    @work.clock_out
    
    respond_to do |format|
      format.html { redirect_to invoices_path(@client) }
      format.js do
        render :json => {
          :work => render_to_string(:partial => @work),
          :total => @work.invoice_total
        }
      end
    end
  end
  
  def merge
    @work = Work.merge_from_ids params[:line_item_ids]
    @invoice = @work.invoice || @client.build_invoice_from_unbilled
    respond_to do |format|
      format.html { redirect_to invoices_path(@client) }
      format.js { render @work }
    end
  end

  def convert
    @work = Work.find params[:id]
    @work.to_adjustment!
    flash[:notice] = "Time item converted to adjustment"
    redirect_to invoices_path(@client)
  end

  private

    def get_client
      @client = (@work.try(:client) || Client.find(params[:client_id]))
    end

    def authorized?
      current_user.authorized? @client
    end
end
