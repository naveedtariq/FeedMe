class Location < ActiveRecord::Base

	include CuisineLibrary::Addressable

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

	def self.extract_obj_params_from_input(params)
		RAILS_DEFAULT_LOGGER.debug "Location.extract_obj_params_from_input: #{params}"
		if params.is_a? String
			{:raw_address => params}
		elsif params.is_a? GeoKit::GeoLoc
			{:lng => params.lng, :lat => params.lat, :country => params.country_code, :zip => params.zip, :state => params.state, :apt => params.apt,
				:city => params.city, :street => params.street_address, :raw_address => params.full_address}
		elsif params.is_a? GeoKit::LatLng
			{:lng => params.lng, :lat => params.lat}
		else
			params
		end
	end

	def address_string
		"#{street} #{apt}, #{city}, #{state}, #{zip}"
	end



	def initialize(params = nil)
		options = Location.extract_obj_params_from_input(params)
		super(options)
		geocode(raw_address) unless self.coordinates?
		set_timezone
	end

	protected
	def set_defaults
		self.name = street                            if  self.name.blank?
		true
	end

	def geocode(ls)
		return if ls.blank? or self.coordinates?
		RAILS_DEFAULT_LOGGER.debug "Location.geocode: geocoding #{ls}"
		geo = GeoKit::Geocoders::MultiGeocoder.geocode(ls)
		self.attributes = self.attributes.merge({:lng => geo.lng, :lat => geo.lat, :country => geo.country_code, :zip => geo.zip, :state => geo.state, :city => geo.city, :street => geo.street_address})
	end

	def set_timezone
		if self.time_zone.nil? and self.coordinates?
			z = Zipcode.find_closest(:origin => self)
			self.time_zone = z.timezone unless z.nil?
			self.time_zone = "US/Central" if self.time_zone.blank? && ENV['RAILS_ENV'] == 'test'
		end
	end

end
