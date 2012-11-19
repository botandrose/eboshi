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

class Work < LineItem
  validates_presence_of :user, :start, :finish

  scope :complete, :conditions => "start <> finish"
  
  def self.merge_from_ids(ids)
    works = Work.find ids, :order => "finish DESC"
    hours = works.sum(&:hours)
    notes = works.collect(&:notes_with_period).select(&:present?).join(' ')
    works.first.update_attributes :hours => hours, :notes => notes

    Work.destroy ids[1..-1] # destroy all but the first work

    works.first
  end

  def to_adjustment!
    self.type = "Adjustment"
    self.rate = self.total
    self.finish = self.start
    save!
  end

  def total
    (rate * hours).round(2)
  end
  
  def total=(value)
    self.hours = value/rate
  end
  
  def hours=(total)
    update_attribute :finish, start + total.hours
  end
  
  def clock_out
    update_attributes :finish => Time.now
  end
  
  def incomplete?
    start >= finish
  end
end
