module CuisineLibrary
  module Addressable
    include GeoKit::Geocoders

    def self.included(base)
      base.composed_of :address, :class_name => 'Address', :mapping => [%w{street street}, %w{city city}, %w{state state}, %w{zip zip}, %w{country country}]
      base.validates_presence_of :street,   :if => :city_and_street_required?
      base.validates_presence_of :city,     :if => :city_and_street_required?
      base.validates_presence_of :zip,      :if => :zip_required?
      base.validates_format_of :zip, :with => Format::ZIP_CODE, :if => :zip_required?
      base.before_save :geocode_lookup
      base.before_validation :set_defaults
      base.alias_attribute :street_address, :street
    end

    def coordinates
      [ lat, lng ]
    end

    def coordinates?
      !lat.nil? && !lng.nil? && !lng.blank? && !lat.blank?
    end

    protected
      def set_defaults
        self.country = "us" if self.country.blank?
        true
      end

      def zip_required?
        city.blank? || street.blank?
      end

      def city_and_street_required?
        zip.blank?
      end

      def geocode_lookup
        attr_names = {
          :city     => :city,
          :street   => :street_address,
          :zip      => :zip,
          :country  => :country_code,
          :state    => :state,
          :lat      => :lat,
          :lng      => :lng
        }

        result = MultiGeocoder.geocode(address.to_s)

        if result.success
          attr_names.each { |k,v| write_attribute k, result.send(v) if result.send(v) }
        end
      end
  end
end