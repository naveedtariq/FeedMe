class Cart 
	attr_accessor :user_id, :restaurant_id, :items, :total, :fulltotal, :fee, :tax, :location, :card, :date, :time, :full_date, :tip, :tipercent

	def initialize(params)
		@items = []
		@fulltotal = 0
		@total = 0
		@fee = 0
		@tax = 0
    @tip = 0
    @tipercent = 0

		@user_id = params[:user_id]
		@restaurant_id = params[:restaurant_id]
	end

	def add_item(item, fee_details, tip)
		@items << item
		@total = (@total + item.total).round(2)
		@fee = (fee_details['fee'].to_f).round(2)
		@tax = (fee_details['tax'].to_f).round(2)
    @tip = calculate_tip(@total,tip)
    @tipercent = (tip.to_f).round(2)
		@fulltotal = (@total + @fee + @tax + @tip).round(2)
	end

	def remove_item(id,fee_details)
		@items.each do |item|
			if item.id.to_s == id then
				@total = (@total - item.total).round(2)
				@removed_item = @items.delete(item)
			end
		end
		
		if @items.count == 0
			@fee = 0
			@tax = 0
		else
			@fee = (fee_details['fee'].to_f).round(2)
			@tax = (fee_details['tax'].to_f).round(2)
		end
		
		@fulltotal = (@total + @fee + @tax + @tip).round(2)
	end

  def update_item(id, fee_details, count)
    removed_item = 0
		@items.each do |item|
			if item.id.to_s == id then
				@total = (@total - item.total).round(2)
				removed_item = @items.delete(item)
			end
		end
    removed_item.update_quantity(count)
    add_item(removed_item, fee_details, @tipercent)
  end

  def update_tip(tipercent)
    self.tipercent = tipercent.to_f.round(2)
    self.fulltotal = self.fulltotal - self.tip
    self.tip = calculate_tip(self.total, tipercent)
    self.fulltotal = (self.fulltotal + self.tip).round(2)
  end

	def empty
		@items = []
	 	@fulltotal = 0
		@total = 0
		@fee = 0
		@tax = 0
    @tip = 0
    @tipercent = 0
	end

	def tray
		tray_str = ""
		self.items.each do |item|
			tray_str = tray_str + item.tray.to_s + "+"
		end
		tray_str.chomp("+")
	end

	def update_fee_details(fee_details)
		@fee = (fee_details['fee'].to_f).round(2)
		@tax = (fee_details['tax'].to_f).round(2)
		@fulltotal = (total + @fee + @tax + tip).round(2)
	end
  protected
  def calculate_tip(total, tip)
    (total * tip.to_f * 0.01).round(2)
  end

end
