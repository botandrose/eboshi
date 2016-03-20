require 'active_support/core_ext/object/conversions'

module DateFormatHelper
  extend self

  def rfc822 date
    return unless date
    date.to_date.to_formatted_s(:rfc822)
  end
end

