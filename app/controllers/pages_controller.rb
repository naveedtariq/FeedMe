class PagesController < ApplicationController

  layout nil

  def callback
		set_up_facebook_user(params[:code]) unless params[:code].empty?
		redirect_to 'http://apps.facebook.com/neolaism'
  end

  def home; end
  
  def facebook_submit; end
end
