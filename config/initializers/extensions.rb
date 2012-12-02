module ActiveRecord
  class Base  
    def id_or_new
      id ? id.to_s : 'new'
    end
  end
end

class Time 
  DATE_FORMATS[:pretty_time] = '%I:%M&nbsp;%p'
  DATE_FORMATS[:slash] = '%m/%d/%y'
end

class Array
  def / pieces
    return [] if pieces.zero?
    piece_size = (length.to_f / pieces).ceil
    [first(piece_size), *last(length - piece_size) / (pieces - 1)]
  end
end

class String
  def url_encode
    CGI::escape(self)
  end
  
  def url_decode
    CGI::unescape(self)
  end
  
  def word_wrap(line_width = 80)
    self.split("\n").collect do |line|
      line.length > line_width ? line.gsub(/(.{1,#{line_width}})(\s+|$)/, "\\1\n").strip : line
    end * "\n"
  end
end

class Date
  def saturday?
    wday == 6
  end
  
  def sunday?
    wday == 0
  end
  
  def today?
    self.to_date == Date.today
  end
end
