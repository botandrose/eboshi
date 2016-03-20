module ApplicationHelper
  def number_to_per_hour(value)
    return nil unless value
    precision = (value.round == value ? 0 : 2)
    number_to_currency(value, precision: precision) + "/hr"
  end

  def currency_or_empty(value)
    return '--' unless value.nonzero?
    number_to_currency value
  end
end
