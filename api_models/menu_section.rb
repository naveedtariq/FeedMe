class MenuSection < ApiModel
	attr_accessor :id, :name, :desc, :menu_items, :raw

	def initialize(params)
		super(params)

		@menu_items = []
    unless params[:raw]["children"].blank?
      params[:raw]["children"].each do |item|
        @menu_items << MenuItem.populate(item)
      end
    end
	end

	def self.populate( data )
		MenuSection.new( {:id => data["id"], :name => data["name"], :raw => data, :desc => data["descrip"] } ) unless data.nil?
	end

end
