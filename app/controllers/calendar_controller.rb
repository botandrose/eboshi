class CalendarController < ApplicationController
  def index
    @date = Date.parse("#{params[:year]}/#{params[:month]}/1") rescue Date.today
  end
end
