class Todo < ActiveRecord::Base
	belongs_to :client
	belongs_to :user

	validates_presence_of :notes
	validates_presence_of :user

	def user_name=(name)
		unless name.nil?
			self.user = User.find_by_login!(name)
		end
	end
end
