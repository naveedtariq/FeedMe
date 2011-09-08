class ApiModel
	attr_accessor :raw

	def initialize( params )
		params.each do |key, value|
			instance_variable_set("@#{key}", value) unless value.nil?
		end
	end

end
