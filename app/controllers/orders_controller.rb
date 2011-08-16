class OrdersController < ApplicationController

  include PublicSection
  include GeoKit::Geocoders
	layout "restaurants"

#	def show
#		render :json => current_cart
#	end

	def create 
		data = ActiveSupport::JSON.decode(params[:data])
		atom = CartItem.new( data )
		current_cart.add_item(atom)
		render :json => current_cart.to_json
	end


	def checkout
		puts "*******\n\n" + current_location.inspect + "**********\n\n"
		current_cart.location = current_location
		current_cart.restaurant_id = 142
		current_cart.card = Card.new({:name => "Abid Mahmood", :number => "4111111111111111", :cvv => "123",
															:bill_addr => current_location.street, :bill_addr2 => current_location.street, :bill_city => current_location.city,
															:bill_state => current_location.state, :expiry => "06/2019", :bill_zip => current_location.zip.split("-")[0]})
		resp = RestApi.place_order(current_cart)
		render :json => resp.to_json + RestApi.order_hash(current_cart).to_json
		
	end

end
