class RestaurantsController < ApplicationController

  include PublicSection
  include GeoKit::Geocoders

  def index
		conditions = {:datetime => 'ASAP', :postal_code => current_location.zip.split("-")[0], :city => current_location.city, :street_address => current_location.street}
		@details = Restaurant.restaurants(conditions)
  end


	def show
		
		@restaurant = Restaurant.restaurant( params[:id] )
		unless @restaurant
			session[:restaurant_id] = @restaurant.id
		end
#puts @restaurant.inspect + '*********************************************'
	end

	def add_favorite
	end

end
