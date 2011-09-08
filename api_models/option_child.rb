class OptionChild < ApiModel
	attr_accessor :id, :name, :price

	def initialize(params)
		super(params)

#puts '--------------------' + params[:raw]["children"].inspect + "--------------------------"

		@children = []
		unless params[:raw]["children"].nil?
			params[:raw]["children"].each do |option|
				@children << option
			end
		end
	end

	def self.populate( data )
		OptionChild.new( {:id => data["id"], :name => data["name"], :price => data["price"], :raw => data} ) unless data.nil?
	end

end
