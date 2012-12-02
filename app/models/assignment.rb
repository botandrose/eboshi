# == Schema Information
# Schema version: 20090412030221
#
# Table name: assignments
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  client_id  :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :client
end
