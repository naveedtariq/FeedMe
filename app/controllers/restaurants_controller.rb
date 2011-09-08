class RestaurantsController < ApplicationController

#include PublicSection
#include GeoKit::Geocoders
	
#caches_page :index, :show

  def index
		@location = current_location
		conditions = {:datetime => 'ASAP', :postal_code => @location.zip.split("-")[0], :city => @location.city, :street_address => @location.street}
		@details = Restaurant.restaurants(conditions).paginate(:page => params[:page], :per_page => 3)
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
