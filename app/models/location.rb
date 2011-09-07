class Location < ActiveRecord::Base

	acts_as_mappable

	belongs_to :user
	has_many :orders

	# composed_of :tz, :class_name => 'TZInfo::Timezone', :mapping => %w( time_zone time_zone )

	default_scope :order => 'created_at DESC'

	before_validation :set_defaults
	# before_validation :set_timezone
	validates_presence_of :street, :zip


	def self.find_same_or_create(user, params = nil)
		options = extract_obj_params_from_input(params)
		loc = find(:first,:conditions => ["user_id = ? AND ((lat = ? AND lng = ?) OR (raw_address = ?))", user.id, options[:lat], options[:lng], options[:raw_address]])
		if !loc
			loc = self.create(options.merge({:user => user}))
		end
		loc
	end

	protected

	def geocode(ls)
		return if ls.blank? or self.coordinates?
		RAILS_DEFAULT_LOGGER.debug "Location.geocode: geocoding #{ls}"
		geo = GeoKit::Geocoders::MultiGeocoder.geocode(ls)
		self.attributes = self.attributes.merge({:lng => geo.lng, :lat => geo.lat, :country => geo.country_code, :zip => geo.zip, :state => geo.state, :city => geo.city, :street => geo.street_address})
	end

end
