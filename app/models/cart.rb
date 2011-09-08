class Cart 
	attr_accessor :user_id, :restaurant_id, :items, :total, :location, :card, :date, :time

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

	def remove_item(id)
		@items.each do |item|
			if item.id.to_s == id then
				@total = @total - item.total
				@items.delete(item)
			end
		end
	end

	def empty
		@items = []
		@total = 0
	end

	def tray
		tray_str = ""
		self.items.each do |item|
			tray_str = tray_str + item.tray.to_s + "+"
		end
		tray_str.chomp("+")
	end

end
