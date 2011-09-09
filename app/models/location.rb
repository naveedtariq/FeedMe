class Location < ActiveRecord::Base

	belongs_to :user
	has_many :orders

	default_scope :order => 'created_at DESC'
	validates_presence_of :street, :zip

	def self.find_same_or_create(user, options = nil)
		puts "TRYING to FIND ALREADY LOCATIONS --------\n\n"
		loc = find(:first,:conditions => ["user_id = ? AND raw_address = ?", user.id, options[:street]])
		if !loc
			puts "-----------------------------OK!----------------------------"
			loc = self.create(options.merge({:user => user}))
			loc.geocode_address
			loc.save
		end
		loc
	end

	def address
		self.street + ', ' + self.zip.to_s
	end

	def geocode_address
		return if address.blank?
		geo = RestApi.geocode(address)

		parsed_geo = Location.parse_geo(geo)
		
#puts "\n\n*************************************" + geo.inspect + "******************************\n\n\n\n"

		self.attributes = self.attributes.merge({:country => parsed_geo[:country], :zip => parsed_geo[:zip], :state => parsed_geo[:state], :city => parsed_geo[:city], :street => "#{parsed_geo[:street_number]} #{parsed_geo[:route]}" })
#self.attributes = self.attributes.merge({:lng => '234', :lat => '234', :country => 'US', :zip => '77840', :state => 'TX', :city => 'College Station', :street => '1900 Texas Ave S'})
	end

protected
	def self.parse_geo(geo)
		parsed = {}
		geo['results'][0]['address_components'].each do |comp|
			parsed[Location.sanitize_key(comp['types'][0].to_sym)] = comp['long_name']
		end

		puts "********* parsed GEO #{parsed} ****************\n\n"
		parsed
	end

	def self.sanitize_key(key)
		lookups = Hash.new { |hash, key| hash[key] = "#{key}" }
		lookups[:locality] = 'city'
		lookups[:administrative_area_level_1] = 'state'
		lookups[:postal_code] = 'zip'

		lookups[key].to_sym
	end

end
