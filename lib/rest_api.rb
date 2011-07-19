class RestApi
	include HTTParty
	base_uri 'http://r.ordr.in:8000/'
	format :json

#	/dl/[datetime]/[postal code]/[city]/[street address]
	def self.restaurants(params)
		url = "/frl/#{params[:datetime]}/#{params[:postal_code]}/#{params[:city]}/#{params[:street_address]}"
		self.do_get(url)
	end

#	/rd/[restaurant id]
	def self.restaurant(params)
		url = "/frd/#{params[:id]}"
		self.do_get(url)
	end


	protected
	
	def self.add_auth_params(url)
		url+"?"+self.auth_params
	end

	def self.do_get(url)
		get(URI.escape( add_auth_params url )).parsed_response
	end

	def self.do_post
	end

	def self.auth_params
		'_auth=1,XA7SvpiY4BGfxtFwIxM4vw'
	end

end

