class Budget < ActiveRecord::Base
  belongs_to :client, touch: true
  has_many :invoices

  attr_accessor :unbilled_invoice

  def used
    invoices.to_a.sum(&:total) + unbilled_invoice.try(:total).to_f
  end

  def remaining
    total - used
  end

  def name_and_total
    [name, total.to_s].join(" - $")
  end

  def under?
    used < total
  end

  def over?
    used > total
  end
end

