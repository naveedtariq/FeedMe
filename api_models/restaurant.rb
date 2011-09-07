class Restaurant < ApiModel
	attr_accessor :id, :name, :logo, :phone, :menu_sections, :raw

	def initialize(params)
		super(params)

		@menu_sections = []
		params[:raw]["menu"].each do |menu|
			@menu_sections << MenuSection.populate(menu)
		end

	end


	def self.restaurant( id )
		self.populate id, RestApi.restaurant({:id => id})
	end


	def self.restaurants( conditions ) 
		list = Array.new

		all = RestApi.restaurants(conditions)
		
		all.each_with_index do |item, index|
#if index == 4
#				break
#			end
			list << self.restaurant( item["id"] ) unless item.nil?
		end
		list
	end


	def image
		"https://r.ordr.in/" + self.logo 
	end

	def phone_number
		self.raw["cs_contact_phone"]
	end

	def fax_number
		nil
	end

	def open_times_string
		self.raw["meal_hours"].to_s
	end

	def can_deliver?
		false
	end

	def delivering?
		self.raw["delivery_zones"] != nil
	end

	def delivering_string
		'TODO: not delivering?'
	end

	def delivery_note
		nil
	end

#TODO
	def specials
		specials = Array.new
	end

#TODO
	def combos
		combos = Array.new
	end

#TODO
	def open?
		true
	end

#TODO
	def is_favorite?
		false
	end

	def address_string
		self.name + ', ' + self.raw["city"] + ', ' + self.raw["state"] + ', ' + self.raw["postal_code"]
	end
	
	protected
	
	def self.populate( id, data )
		Restaurant.new( {:id => id, :name => data["name"], :raw => data, :logo => data["rds_info"]["logo"] } ) unless data.nil?
	end

end
