# == Schema Information
# Schema version: 20081222015211
#
# Table name: invoices
#
#  id           :integer(4)      not null, primary key
#  client_id    :integer(4)
#  date         :datetime
#  project_name :string(255)
#

class Invoice < ActiveRecord::Base
  belongs_to :client
  has_many :line_items, :dependent => :nullify
  has_many :payments, -> { order('created_at DESC') }, dependent: :destroy
  
  validates_presence_of :client, :date

  default_value_for(:date) { Time.zone.today.midnight }

  def self.unpaid
    order("`date` DESC").reject(&:paid?)
  end
  
  def self.paid
    order("`date` DESC").select(&:paid?)
  end
  
  def works
    line_items.where(:type => "Work")
  end

  def adjustments
    line_items.where(:type => "Adjustment")
  end

  def total
    line_items.to_a.sum(&:total)
  end

  def total_for_user(user)
    line_items.to_a.select { |li| li.user == user }.sum(&:total)
  end
  
  def total=(value)
    difference = value.to_f - total
    return total if difference.abs < 0.01
    line_items << Adjustment.new(:total => difference, :client_id => client_id)
  end
  
  def balance
    total - payments.to_a.sum(&:total)
  end

  def status
    return 'unbilled' if new_record?
    return paid? ? 'paid' : 'unpaid'
  end
  
  def paid?
    !line_items.empty? && !payments.empty? && balance == 0
  end
  
  def total_hours
    line_items.to_a.sum(&:hours)
  end
  
  def total_hours_for_user(user)
    line_items.to_a.select { |li| li.user == user }.sum(&:hours)
  end
  
  def consistant_rate
    return true if works.empty?
    rates = works.collect(&:rate).uniq
    rates.length == 1 ? rates.first : false
  end

  def users
    line_items.collect(&:user).uniq.sort_by { |user| user ? user.name : "" }
  end
end
  
