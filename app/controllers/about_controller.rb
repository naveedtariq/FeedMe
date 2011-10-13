class AboutController < ApplicationController

  layout 'restaurants'

	def contact
		@feedback = Feedback.new
	end

	def faqs
		@faqs = Faq.all
	end

end
