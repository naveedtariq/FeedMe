class CartItem
	attr_accessor :id, :name, :price, :options, :total

	def initialize(params)
		@total = 0
		@options = []

		@name = params[:name]
		@price = params[:price].to_f
		@id = params[:id]
	end

	def add_option(option)
		@options << option

		@total = @total + option.price
	end

end
