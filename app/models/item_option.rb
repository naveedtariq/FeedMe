class ItemOption
	attr_accessor :id, :name, :price

	def initialize(params)
		params.symbolize_keys!
		@name = params[:name]
		@price = params[:price].to_f
		@id = params[:id]
	end

	def tray
		return ","+self.id.to_s
	end

end
