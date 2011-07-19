class RestaurantsController < ApplicationController

  include PublicSection
  include GeoKit::Geocoders

  def index
		conditions = {:datetime => 'ASAP', :postal_code => current_location.zip, :city => current_location.city, :street_address => current_location.street}
		@details = Restaurant.restaurants(conditions)
  end


	def show
		@restaurant = Restaurant.restaurant( params[:id] )
#puts @restaurant.inspect + '*********************************************'
	end

end
