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


	def emptycart
		current_cart.empty
		render :text => 'done'
	end

	def remove
		current_cart.remove_item(params[:id])
		render :json => current_cart.to_json
	end

	def getcart
		render :json => current_cart.to_json
	end

	def candeliver
		location = current_location
		params[:city] = location.city
		params[:zip] = current_location.zip.split("-")[0]
		params[:id] = session[:restaurant_id]

		resp = RestApi.check_delivery(params)
		puts resp.inspect + 'wwwwwwwwwwwwwwwwwwwwwwwwwwwwwww'
		render :json => resp.to_json
	end

	def checkout
#puts "*******\n\n" + current_location.inspect + "**********\n\n"
#puts "*******------\n\n" + params.inspect + "**********\n\n"
		current_cart.location = current_location
		current_cart.restaurant_id = session[:restaurant_id]

		#overriding paramas
		params[:bill_addr] = current_location.street
		params[:bill_addr2] = current_location.street
		params[:bill_city] = current_location.city
		params[:bill_state] = current_location.state
		params[:bill_zip] = current_location.zip.split("-")[0]

#puts "*******------\n\n" + params.inspect + "**********\n\n"

		current_cart.card = Card.new(params)

		current_cart.date = params[:date]
		current_cart.time = params[:time]

#working test data below
#		current_cart.card = Card.new({:name => "Abid Mahmood", :number => "4111111111111111", :cvv => "123",
#														:bill_addr => current_location.street, :bill_addr2 => current_location.street, :bill_city => current_location.city,
#														:bill_state => current_location.state, :expiry => "06/2019", :bill_zip => current_location.zip.split("-")[0]})

		resp = RestApi.place_order(current_cart)

#render :json => resp.to_json + RestApi.order_hash(current_cart).to_json
#{"_error":0,"msg":"Success","text":"Thank you for your order!"}
		render :json => resp.to_json
	end

end
