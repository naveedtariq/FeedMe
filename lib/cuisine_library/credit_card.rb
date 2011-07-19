# These functions tell you whether a credit card number is
# self-consistent using known algorithms for credit card numbers.
# All non-integer values are removed from the string before parsing
# so that you don't have to worry about the format of the string.
#
# == Usage
# require "creditcard"
#
# "5276 4400 6542 1319".creditcard?
#	=> true
#
# puts 5276440065421319.creditcard_type
#	=> "mastercard"
#
# "5276440065421319".creditcard? "visa"
#	=> false
#
# "5276-4400-6542-1319".creditcard? "mastercard"
#	=> true
#
# Ported from the Perl version by Jon Orwant and Ivan Kohler
# http://search.cpan.org/~ivan/Business-CreditCard-0.28/CreditCard.pm
#
# Author::    Lucas Carlson  (mailto:lucas@rufy.com)
# Copyright:: Copyright (c) 2005 Lucas Carlson
# License::   Distributes under the same terms as Ruby

module CuisineLibrary
  module CreditCard
  	# Returns a string containing the type of card from the list of known information below.
  	# == Known card types
  	#	*Card Type*                       *Prefix*                         *Length*
  	#	mastercard                        51-55                            16
  	#	visa                              4                                13, 16
  	#	american_express                  34, 37                           15
  	#	diners_club                       300-305, 36, 38                  14
  	#	enroute                           2014, 2149                       15
  	#	discover                          6011                             16
  	#	jcb                               3                                16
  	#	jcb                               2131, 1800                       15
  	#	bankcard                          5610, 56022[1-5]                 16
  	#	switch                            various                          16,18,19
  	#	solo                              63, 6767                         16,18,19
  	def creditcard_type
  		number = self.to_s.gsub(/[^\d]/, "")

  		return 'visa' if number =~ /^4\d{12}(\d{3})?$/
  		return 'mastercard' if number =~ /^5[1-5]\d{14}$/
  		return 'discover' if number =~ /^6011\d{12}$/
  		return 'american_express' if number =~ /^3[47]\d{13}$/
  		return 'diners_club' if number =~ /^3(0[0-5]|[68]\d)\d{11}$/
  		return 'enroute' if number =~ /^2(014|149)\d{11}$/
  		return 'jcb' if number =~ /^(3\d{4}|2131|1800)\d{11}$/
  		return 'bankcard' if number =~ /^56(10\d\d|022[1-5])\d{10}$/
  		return 'switch' if number =~ /^49(03(0[2-9]|3[5-9])|11(0[1-2]|7[4-9]|8[1-2])|36[0-9]{2})\d{10}(\d{2,3})?$/ || number =~ /^564182\d{10}(\d{2,3})?$/ || number =~ /^6(3(33[0-4][0-9])|759[0-9]{2})\d{10}(\d{2,3})?$/
  		return 'solo' if number =~ /^6(3(34[5-9][0-9])|767[0-9]{2})\d{10}(\d{2,3})?$/
  		return 'unknown'
  	end

  	# Returns true if it validates. Optionally, you can pass a card type as an argument and make sure it is of the correct type.
  	# == References
  	# - http://perl.about.com/compute/perl/library/nosearch/P073000.htm
  	# - http://www.beachnet.com/~hstiles/cardtype.html
  	def creditcard?(type = nil)
  		number = self.to_s.gsub(/[^\d]/, "")
  		return false unless number.length >= 13

  		if type
  			return false unless creditcard_type == type
  		end

  		sum = 0
  		for i in 0..number.length
  			weight = number[-1*(i+2), 1].to_i * (2 - (i%2))
  			sum += (weight < 10) ? weight : weight - 9
  		end

  		return true if number[-1,1].to_i == (10 - sum%10)%10
  		return false
  	end
  end
end

class String#:nodoc:
	include CuisineLibrary::CreditCard
end

class Integer#:nodoc:
	include CuisineLibrary::CreditCard
end