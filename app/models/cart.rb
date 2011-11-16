class Cart 
	attr_accessor :user_id, :restaurant_id, :items, :total, :fulltotal, :fee, :tax, :location, :card, :date, :time

	def initialize(params)
		@items = []
		@fulltotal = 0
		@total = 0
		@fee = 0
		@tax = 0

		@user_id = params[:user_id]
		@restaurant_id = params[:restaurant_id]
	end

	def add_item(item,fee_details)
		@items << item
		@total = @total + item.total
		@fee = fee_details['fee'].to_f
		@tax = fee_details['tax'].to_f
		@fulltotal = @total + @fee + @tax
	end

	def remove_item(id,fee_details)
	puts 222
	puts id
	puts 1111
		@items.each do |item|
						puts 333
						puts item.id.to_s
			if item.id.to_s == id then
				@total = @total - item.total
				@items.delete(item)
			end
		end
		
		if @items.count == 0
			@fee = 0
			@tax = 0
		else
			@fee = fee_details['fee'].to_f
			@tax = fee_details['tax'].to_f
		end
		
		@fulltotal = @total + @fee + @tax
	end

	def empty
		@items = []
	 	@fulltotal = 0
		@total = 0
		@fee = 0
		@tax = 0
	end

	def tray
		tray_str = ""
		self.items.each do |item|
			tray_str = tray_str + item.tray.to_s + "+"
		end
		tray_str.chomp("+")
	end

end
