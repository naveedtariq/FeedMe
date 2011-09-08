class MenuItemOption < ApiModel
	attr_accessor :id, :name, :price, :children, :raw

	def initialize(params)
		super(params)

#puts '--------------------' + params[:raw]["children"].inspect + "--------------------------"

		@children = []
		unless params[:raw]["children"].nil?
			params[:raw]["children"].each do |option|
				@children << OptionChild.populate(option) 
			end
		end
	end

	def self.populate( data )
		MenuItemOption.new( {:id => data["id"], :name => data["name"], :price => data["price"], :raw => data} ) unless data.nil?
	end

end
