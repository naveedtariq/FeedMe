class Location < ActiveRecord::Base

	acts_as_mappable
	before_validation :geocode_address, :on => :create

	belongs_to :user
	has_many :orders

	default_scope :order => 'created_at DESC'
	validates_presence_of :street, :zip

	def self.find_same_or_create(user, params = nil)
		options = extract_obj_params_from_input(params)
		loc = find(:first,:conditions => ["user_id = ? AND ((lat = ? AND lng = ?) OR (raw_address = ?))", user.id, options[:lat], options[:lng], options[:raw_address]])
		if !loc
			loc = self.create(options.merge({:user => user}))
		end
		loc
	end

	def address
		self.street + ', ' + self.zip.to_s
	end

	protected

	def geocode_address
		puts "\n\n*************************************" + address + "******************************\n\n\n\n"

		return if address.blank?

		RAILS_DEFAULT_LOGGER.debug "Location.geocode: geocoding #{address}"
		geo = GeoKit::Geocoders::MultiGeocoder.geocode(address)
		self.attributes = self.attributes.merge({:lng => geo.lng, :lat => geo.lat, :country => geo.country_code, :zip => geo.zip, :state => geo.state, :city => geo.city, :street => geo.street_address})
	end

end
