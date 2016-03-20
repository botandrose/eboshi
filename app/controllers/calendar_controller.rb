class CalendarController < ApplicationController
  def index
    @date = begin
              Date.parse("#{params[:year]}/#{params[:month]}/1")
            rescue
              Date.today
            end
  end
end
