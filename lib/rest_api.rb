class RestApi
	include HTTParty
	base_uri 'http://o-test.ordr.in:8000/'
	format :json

#	/dl/[datetime]/[postal code]/[city]/[street address]
	def self.restaurants(params)
		url = "/dl/#{params[:datetime]}/#{params[:postal_code]}/#{params[:city]}/#{params[:street_address]}"
		respt = self.do_get(url)
		puts respt.to_json + "-----------------------------**-------"
		respt
	end

#	/rd/[restaurant id]
	def self.restaurant(params)
		url = "/rd/#{params[:id]}"
		self.do_get(url)
	end
	
	#	/rd/[restaurant id]
	def self.get_fee_details(params)
		url = "/fee/#{params[:id]}/#{params[:total]}/#{params[:tip]}/ASAP/#{params[:zip]}/#{params[:city]}/#{params[:street]}"
		self.do_get(url)
	end

	def self.get_fee_details_with_time(params)
		url = "/fee/#{params[:id]}/#{params[:total]}/#{params[:tip]}/#{params[:date]}/#{params[:zip]}/#{params[:city]}/#{params[:street]}"
		self.do_get(url)
	end

	def self.check_delivery(params)
		url = "/dc/#{params[:id]}/#{params[:date]}+#{params[:time]}/#{params[:zip]}/#{params[:city]}/#{params[:street]}"
		self.do_get(url)
	end
	
	def self.place_order(cart, option)
		url = "/o/#{cart.restaurant_id}"
#url = "http://www.postbin.org/14evnuh/#{cart.restaurant_id}"
    options = { :body => self.order_hash(cart, option)}
		self.do_post(url, options)
	end

	def self.geocode(address)
		base = 'https://maps.googleapis.com/maps/api/geocode/json?';
		base = base + 'address='+address+'&sensor=false';
		get(URI.escape( base )).parsed_response
	end

	def self.order_hash(order, options)
#		user = User.find(order.user_id)
		user = User.find(1)

#TODO: Tray not working, ASAP in delivery_date Not working

		{ :restaurant_id => order.restaurant_id,
			:type => 'RES',
			:tray => order.tray, :tip => order.tip,	:delivery_date => order.date, :delivery_time => order.time, :first_name => user.name,
			:last_name => user.name, :addr => order.location.street, :city => order.location.city,
			:state => order.location.state, :zip => order.location.zip.split("-")[0], :phone => "2125551212", :em => user.facebook_email,
			:card_name => order.card.name, :card_number => order.card.number, :card_cvc => order.card.cvv,
			:card_expiry => order.card.expiry, :card_bill_addr => order.card.bill_addr, :card_bill_addr2 => order.card.bill_addr2,
			:card_bill_city => order.card.bill_city, :card_bill_state => order.card.bill_state, :card_bill_zip => order.card.bill_zip.split("-")[0],
      :phone => options["phone"]}
	end

	protected

	def self.add_auth_params(url)
		url+"?"+self.auth_params
	end

	def self.do_get(url)
		puts "\n******** API CALL\n" + self.base_uri + URI.escape( add_auth_params url ).inspect + "\n\n"
		get(URI.escape( add_auth_params url )).parsed_response
	end

	def self.do_post(url, options)
		RAILS_DEFAULT_LOGGER.debug "REST API POST ------ " + options.inspect
		puts(options.to_json)
		puts(URI.escape( add_auth_params url )+ "-----------------------")
		post(URI.escape( add_auth_params url ), options).parsed_response
	end

	def self.auth_params
		'_auth=1,XA7SvpiY4BGfxtFwIxM4vw'
	end

end

