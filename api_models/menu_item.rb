class MenuItem < ApiModel
	attr_accessor :id, :name, :price, :desc, :raw

	def initialize(params)
		super(params)
	end

	def self.populate( data )
		MenuItem.new( {:id => data["id"], :name => data["name"], :desc => data["descrip"], :raw => data, :price => data["price"] } ) unless data.nil?
	end

end
