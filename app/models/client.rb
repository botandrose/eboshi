# == Schema Information
# Schema version: 20081222015211
#
# Table name: clients
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  address    :string(255)
#  city       :string(255)
#  state      :string(255)
#  zip        :string(255)
#  country    :string(255)
#  email      :string(255)
#  contact    :string(255)
#  phone      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Client < ActiveRecord::Base
  default_scope -> { order(:name) }

  has_many :line_items, :dependent => :destroy
  has_many :works
  has_many :adjustments
  has_many :invoices, -> { includes(:line_items, :payments).order('`date` DESC') }, dependent: :destroy
  has_many :payments, :through => :invoices
  has_many :assignments, :dependent => :destroy
  has_many :users, :through => :assignments

  validates_presence_of :name

  def build_invoice_from_unbilled(line_items_ids = nil)
    lis = line_items_ids ? LineItem.find(line_items_ids) : line_items.unbilled
    invoices.build :line_items => lis
  end

  def invoices_with_unbilled
    new_invoices = invoices.to_a
    new_invoices.unshift build_invoice_from_unbilled
    new_invoices
  end

  def balance
    credits - debits
  end

  def unbilled_balance
    return 0.0 if line_items.empty?
    line_items.to_a.select(&:unbilled?).sum(&:total)
  end

  def overdue_balance
    balance - unbilled_balance
  end

  def credits
    line_items.to_a.sum(&:total)
  end

  def debits
    payments.to_a.sum(&:total)
  end

  def clock_in(user)
    Work.new.tap do |line_item|
      now = Time.now
      line_item.attributes = { :start => now, :finish => now, :user => user, :rate => user.default_rate_for(self) }
      self.line_items << line_item
    end
  end

  def default_project_name
    invoices.last.try(:project_name)
  end
end
