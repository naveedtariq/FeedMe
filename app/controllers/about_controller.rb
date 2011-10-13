class AboutController < ApplicationController

  layout 'restaurants'

	def index
	
	end

	def faqs
		@faqs = Faq.all
	end

	def privacy

	end

	def terms
	
	end

	def advertisers
	
	end

	def restaurant_owners
	
	end

end
