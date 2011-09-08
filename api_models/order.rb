class Order < ApiModel
	
	attr_accessor :order_info

	def initialize(params)
		super(params)
		@order_info = params
	end

	def place
		RestApi.place_order(@order_info)
	end

end
