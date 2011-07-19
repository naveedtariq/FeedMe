class Address
  attr_reader :street, :city, :state, :zip, :country
  
  def initialize(street, city, state, zip, country = 'us')
    @street, @city, @state, @zip, @country = street, city, state, zip, country
  end
  
  def to_s
    "#{street}, #{city}, #{state} #{zip}"
  end
end
