# == Schema Information
# Schema version: 20081222015211
#
# Table name: payments
#
#  id         :integer(4)      not null, primary key
#  invoice_id :integer(4)
#  total      :decimal(10, 2)
#  created_at :datetime
#  updated_at :datetime
#

class Payment < ActiveRecord::Base
  belongs_to :invoice, touch: true
end
