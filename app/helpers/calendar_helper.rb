require 'date'

module CalendarHelper
  def calendar(options = {}, &block)
    block ||= Proc.new {|d| nil}

    defaults = {
      :year => Time.zone.today.year,
      :month => Time.zone.today.month,
      :previous_month_text => nil,
      :next_month_text => nil
    }
    options.reverse_merge! defaults

    first = Date.civil(options[:year], options[:month], 1)
    last = first.end_of_month

    build first, last, options, &block
  end

  private

  def build first, last, options, &block
    haml_tag :tbody do
      haml_tag :tr do
        last_month_days first # start out the week with last month's days
        this_month_days first, last, &block
        next_month_days last # finish out the week with next month's days
      end
    end
  end

  def last_month_days first
    first.beginning_of_week(:sunday).upto(first - 1.day) do |d|
      haml_tag :td, :class => "otherMonth" do
        haml_concat d.day
      end
    end
  end

  def this_month_days first, last, &block
    first.upto(last) do |d|
      classes = []
      classes << "today" if d.today?
      haml_tag :td, :id => "day_#{d.day}", :class => classes.compact.join(' ') do
        haml_concat d.mday
        haml_concat capture_haml(d, &block)
      end
      haml_concat "</tr><tr>" if d.saturday? unless d == last
    end
  end

  def next_month_days last
    unless last.saturday?
      (last + 1).upto(last.end_of_week(:sunday)) do |d|
        haml_tag :td, :class => "otherMonth" do
          haml_concat d.day
        end
      end
    end
  end
end

module CalendarHelper
  def link_to_previous_month(date, options = {})
    link_to_month(:prev, date, options)
  end

  def link_to_next_month(date, options = {})
    link_to_month(:next, date, options)
  end

  private

  def link_to_month(direction, date, options = {})
    date += (direction == :next ? 1 : -1).month
    link_to direction, calendar_path(:year => date.year, :month => date.month), options
  end
end
