class RestApi
	include HTTParty
	base_uri 'http://o-test.ordr.in:8000/'
	format :json

#	/dl/[datetime]/[postal code]/[city]/[street address]
	def self.restaurants(params)
		url = "/dl/#{params[:datetime]}/#{params[:postal_code]}/#{params[:city]}/#{params[:street_address]}"
		respt = self.do_get(url)
		puts respt.to_json + "--------------------------------------"
		respt
	end

#	/rd/[restaurant id]
	def self.restaurant(params)
		url = "/frd/#{params[:id]}"
		self.do_get(url)
	end
	
	def self.place_order(cart)
		url = "/o/#{cart.restaurant_id}"
    options = { :body => self.order_hash(cart)}
		self.do_post(url, options)
	end

	def self.order_hash(order)
		{ :tray => order.tray, :tip => 0,	:delivery_date => "ASAP", :first_name => User.find(order.user_id).name,
			:last_name => User.find(order.user_id).name, :addr => order.location.street, :city => order.location.city,
			:state => order.location.state, :zip => order.location.zip.split("-")[0], :phone => "103337896543", :em => "aabaassit@gmail.com",
			:card_name => order.card.name, :card_number => order.card.number, :card_cvv => order.card.cvv,
			:card_expirty => order.card.expiry, :card_bill_addr => order.card.bill_addr, :card_bill_addr2 => order.card.bill_addr2,
			:card_bill_city => order.card.bill_city, :card_bill_state => order.card.bill_state, :card_bill_zip => order.card.bill_zip.split("-")[0]}
	end

	protected

	def self.add_auth_params(url)
		url+"?"+self.auth_params
	end

	def self.do_get(url)
		puts URI.escape( add_auth_params url ).inspect
		get(URI.escape( add_auth_params url )).parsed_response
	end

	def self.do_post(url, options)
		puts(options.to_json)
		puts(URI.escape( add_auth_params url )+ "-----------------------")
		post(URI.escape( add_auth_params url ), options).parsed_response
	end

	def self.auth_params
		'_auth=1,XA7SvpiY4BGfxtFwIxM4vw'
	end

end

