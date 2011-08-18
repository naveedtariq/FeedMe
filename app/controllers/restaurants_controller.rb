class RestaurantsController < ApplicationController

  include PublicSection
  include GeoKit::Geocoders

  def index
		conditions = {:datetime => 'ASAP', :postal_code => current_location.zip.split("-")[0], :city => current_location.city, :street_address => current_location.street}
		@details = Restaurant.restaurants(conditions)
  end


	def show
		
		@restaurant = Restaurant.restaurant( params[:id] )
		@cart = current_cart

		unless @restaurant.nil?
			session[:restaurant_id] = @restaurant.id
		end
#puts "\n\n-------************\n\n" + @cart.inspect + "\n\n*********************************************\n\n"
	end

	def add_favorite
	end

end
