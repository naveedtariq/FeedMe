class User < ActiveRecord::Base

	has_many :locations, :dependent => :destroy
	has_many :favourite_restaurants
	has_many :feedbacks


	def home_location
		@home_location || self.locations.where("is_home_address = true").first
	end

	def home_location_street
		home_location.nil? ? ""  : home_location.street + ", " + home_location.city + ", " + home_location.state
	end

	def home_location_zip
		home_location.nil? ? "" :  home_location.zip
	end

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
