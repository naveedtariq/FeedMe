class FavouriteRestaurant < ActiveRecord::Base
	belongs_to :user
	validates_uniqueness_of :restaurant_id, :scope => :user_id

	def self.favorite?(restaurant_id, user_id)
		!(FavouriteRestaurant.where(:restaurant_id => restaurant_id, :user_id => user_id).empty?)
	end
end


