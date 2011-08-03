class Cart 
	attr_accessor :user_id, :restaurant_id, :items, :total

	def initialize(params)
		@total = 0
		@items = []

		@user_id = params[:user_id]
		@restaurant_id = params[:restaurant_id]
	end

	def add_item(item)
		@items << item
		@total = @total + item.price
	end

end
