class LineItem < ActiveRecord::Base
	belongs_to :client
	belongs_to :user
	belongs_to :invoice

  validates_presence_of :client, :rate
  	
	named_scope :unbilled, :conditions => "invoice_id IS NULL AND start IS NOT NULL", :order => 'start DESC'

	def total
		0
	end

	def hours
		return 0 unless finish and start
		BigDecimal ((finish - start) / 60 / 60).to_s
	end
	
	def == (target)
		target == id
	end
	
	def checked?
		invoice_id.nil?
	end
	
	def user_name=(name)
		unless name.nil?
			self.user = User.find_by_login!(name)
		end
	end
	
	def invoice_total
	  invoice.try(:total) || client.balance
	end
end
