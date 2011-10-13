class FeedbacksController < ApplicationController

	layout 'restaurants'

	def index 
		if params[:feed_me_secret] == 'wajjo'
			render :json => Feedback.all and return
		end
		render :text => "Sorry invalid credentials"
	end

	def new
		@feedback = Feedback.new
	end

	def create
		feedback = Feedback.new(params[:feedback])	
		feedback.user_id = current_user.id	
		feedback.save
		flash[:notice] = "We have recieved your feedback Thank you!!"
		redirect_to root_path
	end

end
