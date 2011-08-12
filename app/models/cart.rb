class Cart 
	attr_accessor :user_id, :restaurant_id, :items, :total, :location, :card

	def initialize(params)
		@total = 0
		@items = []

		@user_id = params[:user_id]
		@restaurant_id = params[:restaurant_id]
	end

	def add_item(item)
		@items << item
		@total = @total + item.total
	end

	def tray
		tray_str = ""
		self.items.each do |item|
			tray_str = tray_str + item.tray.to_s + "+"
		end
		tray_str.chomp("+")
	end

end
