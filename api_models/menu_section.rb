class MenuSection < ApiModel
	attr_accessor :id, :name, :desc, :menu_items, :raw

	def initialize(params)
		super(params)

		@menu_items = []
		params[:raw]["children"].each do |item|
			@menu_items << MenuItem.populate(item)
		end
	end

	def self.populate( data )
		MenuSection.new( {:id => data["id"], :name => data["name"], :raw => data, :desc => data["descrip"] } ) unless data.nil?
	end

end
