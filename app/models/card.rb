class Card 
	attr_accessor :number, :expiry, :cvv, :bill_addr, :name, :bill_addr2, :bill_city, :bill_state, :bill_zip

	def initialize(params)
		@number = params[:number]
		@expiry = params[:expiry]
		@cvv = params[:cvv]
		@bill_addr = params[:bill_addr]
		@name = params[:name]
		@bill_addr2 = params[:bill_addr2]
		@bill_city = params[:bill_city]
		@bill_zip = params[:bill_zip]
		@bill_state = params[:bill_state]
	end

end
