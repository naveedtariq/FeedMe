class PagesController < ApplicationController

  layout nil

  def callback
		set_up_facebook_user(params[:code]) unless params[:code].empty?
		redirect_to new_location_path
  end

  def home; end
  
  def facebook_submit; end
end
