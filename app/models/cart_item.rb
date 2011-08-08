class CartItem
	attr_accessor :id, :name, :price, :options, :total

	def initialize(params)
		@total = 0
		@options = []

		@name = params[:name]
		@price = params[:price].to_f
		@id = params[:id]

		unless params[:options].nil?
			params[:options].each do |opt|
				self.add_option(opt)
			end
		end

	end

	def add_option(option)
		@options << option

		@total = @total + option.price
	end

end
