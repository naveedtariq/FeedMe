class User < ActiveRecord::Base

	has_many :locations, :dependent => :destroy
	has_many :favourite_restaurants

	def self.find_or_create(user)
		u = User.find_by_facebook_uid(user.id) 
		if u 
			return u.id
		end
		user = User.new(:name => user.name, :facebook_city => user.location.to_s.split(",")[0], :facebook_country => user.location.to_s.split(",")[1], :facebook_uid => user.id, :facebook_email => user.email)
		user.save
		return user.id
	end
end
