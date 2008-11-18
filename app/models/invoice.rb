class Invoice < ActiveRecord::Base
	belongs_to :client
	has_many :line_items, :dependent => :destroy
	has_many :todos
	has_many :works
	has_many :adjustments
	
	validates_presence_of :client, :date, :project_name
	
	def initialize(options = {})
		options = {} if options.nil?
		options.reverse_merge!(:date => Date.today)
		super
	end

	def total
		line_items.to_a.sum(&:total)
	end
	
	def total=(value)
		difference = value.to_f - total
		return total if difference < 0.01
		adjustments << Adjustment.new(:client => client, :total => difference)
	end

  def attributes=(attrs)
    # check for nulling checkbox
    attrs.delete_if { |k,v| k =~ /^paid$|^paid\([1-3]i\)$/ } if attrs['paid'] == "0"
    super(attrs)
  end	
end
