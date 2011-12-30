class CartItem
	attr_accessor :id, :name, :price, :options, :total, :qty, :unique_id

	def initialize(params)
		params.symbolize_keys!
		@options = []

		@qty = params[:count]
		@name = params[:name]
		@price = params[:price].to_f
		@id = params[:id]
		@total = @price * params[:count].to_f
		@unique_id = Time.now.gmtoff

		unless params[:options].nil?
			params[:options].each do |opt|
				add_option(ItemOption.new(opt),params[:count].to_f)
			end
		end

	end

  def update_quantity(count)
    @total = @price * count
    @qty = count
    @options.each do |opt|
      @total = @total + (opt.price * count)
    end
  end

	def tray
		tray_str = (self.id.to_s+"/"+self.qty.to_s)
		self.options.each do |option|
			tray_str = tray_str+option.tray.to_s
		end	
		tray_str
	end

	def add_option(option, count)
		@options << option
		@total = @total + (option.price * count)
		puts (option.price)
	end

end
