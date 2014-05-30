# == Schema Information
# Schema version: 20090412030221
#
# Table name: users
#
#  id                     :integer(4)      not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  crypted_password       :string(255)
#  password_salt          :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  rate                   :decimal(10, 2)
#  color                  :string(255)
#  persistence_token      :string(255)
#  login_count            :integer(4)
#  last_request_at        :datetime
#  last_login_at          :datetime
#  current_login_at       :datetime
#  last_login_ip          :string(255)
#  current_login_ip       :string(255)
#  last_client_id         :integer(4)
#  admin                  :boolean(1)
#  logo_file_name         :string(255)
#  logo_content_type      :string(255)
#  logo_file_size         :integer(4)
#  logo_updated_at        :datetime
#  signature_file_name    :string(255)
#  signature_content_type :string(255)
#  signature_file_size    :integer(4)
#  signature_updated_at   :datetime
#

class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::Sha512
  end
  
  belongs_to :last_client, :class_name => "Client"
  has_many :assignments, :dependent => :destroy
  has_many :clients, :through => :assignments, :include => [:line_items, :payments]
  has_many :works
  
  has_attached_file :logo,
    :styles => { :pdf => "200x200>" },
    :path => ":rails_root/public/:attachment/:id/:style.:extension",
    :url => "/:attachment/:id/:style.:extension"
  has_attached_file :signature,
    :styles => { :pdf => "450x100>" },
    :path => ":rails_root/public/:attachment/:id/:style.:extension",
    :url => "/:attachment/:id/:style.:extension"
    
  def default_rate_for(client)
    last_work = client.works.complete.first :conditions => { :user_id => self }, :order => "start DESC"
    last_work.try(:rate) || rate
  end

  def related_users
    clients.collect(&:users).flatten.uniq - [self]
  end
  
  def authorized?(object)
    return if object.is_a? Client and clients.include?(object)
    return if object.is_a? Invoice and clients.include?(object.client)
    return if object.is_a? Assignment and object.client.users.include?(self)
    raise ActiveRecord::RecordNotFound
  end
  
  def city_state_zip
    return nil if city.blank? or state.blank? or zip.blank?
    "#{city}, #{state}  #{zip}"
  end
  
  def business_name_or_name
    business_name.blank? ? name : business_name
  end

  def business_email_or_email
    business_email.blank? ? email : business_email
  end

  def hours_by_date(date)
    works.on_date(date).to_a.sum(&:hours)
  end

  def total_by_date(date)
    works.on_date(date).to_a.sum(&:total)
  end

  def hours_by_week(date)
    works.on_week(date).to_a.sum(&:hours)
  end

  def total_by_week(date)
    works.on_week(date).to_a.sum(&:total)
  end

  def hours_by_month(date)
    works.on_month(date).to_a.sum(&:hours)
  end

  def total_by_month(date)
    works.on_month(date).to_a.sum(&:total)
  end

  def hours_by_year(date)
    works.on_year(date).to_a.sum(&:hours)
  end

  def total_by_year(date)
    works.on_year(date).to_a.sum(&:total)
  end
end
