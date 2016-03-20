# == Schema Information
# Schema version: 20081222015211
#
# Table name: line_items
#
#  id         :integer(4)      not null, primary key
#  client_id  :integer(4)
#  user_id    :integer(4)
#  start      :datetime
#  finish     :datetime
#  rate       :decimal(10, 2)
#  notes      :text
#  created_at :datetime
#  updated_at :datetime
#  invoice_id :integer(4)
#  type       :string(255)
#

class Adjustment < LineItem
  def total
    rate
  end

  def total=(value)
    self.rate = value
  end

  def no_user
    user.nil? && !new_record?
  end

  def no_date
    start.nil? && !new_record?
  end
end
