class OrdersController < ApplicationController

	layout "restaurants"

#	def show
#		render :json => current_cart
#	end

	def create 
		data = ActiveSupport::JSON.decode(params[:data])
		atom = CartItem.new( data )
		current_cart.location = current_location
		params[:id] 		= session[:restaurant_id]
		params[:total] 		= current_cart.total + atom.total
		params[:street] 	= current_location.street
		params[:city] 		= current_location.city
		params[:zip] 		= current_location.zip.split("-")[0]
		resp = RestApi.get_fee_details(params)

		current_cart.add_item(atom, resp, data[:tip].to_f)		
		render :json => current_cart.to_json
	end

	def emptycart
		current_cart.empty
		render :text => 'done'
	end

	def remove
		itemcost = 0
		current_cart.items.each do |item|
			if item.id.to_s == params[:id] then
				itemcost = item.total
			end
		end
		
		item_id = params[:id]
		
		current_cart.location = current_location
		params[:id] 		= session[:restaurant_id]
		params[:total] 		= current_cart.total - itemcost
		params[:street] 	= current_location.street
		params[:city] 		= current_location.city
		params[:zip] 		= current_location.zip.split("-")[0]
		puts resp = RestApi.get_fee_details(params)
		
		puts current_cart.remove_item(item_id,resp).inspect
		render :json => current_cart.to_json
	end

  def update_cart_item
		itemcost = 0
    itemprice = 0
		current_cart.items.each do |item|
			if item.id.to_s == params[:id] then
				itemcost = item.total
        itemprice = item.price
			end
		end
	  itemnewcost = itemprice * params[:quantity].to_f
		item_id = params[:id]
		
		current_cart.location = current_location
		params[:id] 		= session[:restaurant_id]
		params[:total] 		= current_cart.total - itemcost + itemnewcost
		params[:street] 	= current_location.street
		params[:city] 		= current_location.city
		params[:zip] 		= current_location.zip.split("-")[0]
		puts resp = RestApi.get_fee_details(params)
		
		puts current_cart.update_item(item_id,resp,params[:quantity].to_f).inspect
		render :json => current_cart.to_json
    
  end

  def update_tip
		current_cart.update_tip(params[:tipercent])
    @tipercent =  params[:tipercent].to_f.round(2)
		render :json => current_cart.to_json
  end

	def getcart
    puts current_cart.to_json
		render :json => current_cart.to_json
	end

	def candeliver
		location = current_location
		final_date = formatted_date(params[:date])
		params[:date] = final_date[:date]
		params[:time] = final_date[:time] 
		params[:city] = location.city
		params[:zip] = current_location.zip.split("-")[0]
		params[:id] = session[:restaurant_id]

		resp = RestApi.check_delivery(params)
		render :json => resp.to_json
	end

  def checkout_confirmation
    @restaurant = session[:current_restaurant_obj]
    @current_location = current_location
#    return render :json => current_location
  end

  def thankyou
    @cart = current_cart
    @restaurant = session[:current_restaurant_obj]
    @current_location = current_location
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
		final_date = formatted_date(params[:date])
    current_cart.full_date = params[:date]
		current_cart.date = final_date[:date]
		current_cart.time = final_date[:time]

#working test data below
#		current_cart.card = Card.new({:name => "Abid Mahmood", :number => "4111111111111111", :cvv => "123",
#														:bill_addr => current_location.street, :bill_addr2 => current_location.street, :bill_city => current_location.city,
#														:bill_state => current_location.state, :expiry => "06/2019", :bill_zip => current_location.zip.split("-")[0]})

		resp = RestApi.place_order(current_cart, params)

#render :json => resp.to_json + RestApi.order_hash(current_cart).to_json
#{"_error":0,"msg":"Success","text":"Thank you for your order!"}
		render :json => resp.to_json
	end

private

	def formatted_date(date)
		ret = {}
		tm = Time.strptime(date,"%m/%d/%Y %H:%M %p")
		ret[:date] = tm.month.to_s+'-'+tm.day.to_s
		ret[:time] = tm.hour.to_s+":"+((tm.min.to_s.length == 1)? "0"+tm.min.to_s : tm.min.to_s)
		ret
	end
end
