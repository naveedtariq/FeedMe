class ItemOption
	attr_accessor :id, :name, :price

	def initialize(params)
		@name = params[:name]
		@price = params[:price].to_f
		@id = params[:id]
	end

end
