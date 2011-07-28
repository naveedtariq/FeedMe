class MenuItem < ApiModel
	attr_accessor :id, :name, :price, :desc, :children, :raw

	def initialize(params)
		super(params)
#puts '++++++++++++' + params[:raw]["children"].inspect + "++++++++++++++++++++++++++++++"

		@children = []

		unless params[:raw]["children"].nil?
			params[:raw]["children"].each do |option|
				@children << MenuItemOption.populate(option)
			end
		end
	end

	def self.populate( data )
		MenuItem.new( {:id => data["id"], :name => data["name"], :desc => data["descrip"], :price => data["price"], :raw => data} ) unless data.nil?
	end

end
