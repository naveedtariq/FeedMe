class PagesController < ApplicationController

  layout nil

  def callback
		puts "\n\n\nSetting up facebook user\n\n\n"
		set_up_facebook_user(params[:code]) unless params[:code].empty?
		redirect_to 'https://apps.facebook.com/foodcourtapp'
  end

  def home; end
  
  def facebook_submit; 
		
  end
end
