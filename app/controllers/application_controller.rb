class ApplicationController < ActionController::Base
  include SslRequirement  
	include Facebooker2::Rails::Controller 

  helper_method :current_user, :logged_in?, :searching_delivery?

  protect_from_forgery
  filter_parameter_logging :fb_sig_friends

	def current_cart
		session[:current_cart] ||= (session[:current_cart] = Cart.new(:restaurant_id => current_restaurant, :user_id => current_user.id))
		puts session[:current_cart].inspect
		session[:current_cart]
	end

	def current_restaurant
		session[:current_restaurant]
	end
  
	def ensure_authenticated
		if session[:at]
			return true
		end
		session[:at]=nil
		redirect_to authenticator.authorize_url(:scope => 'publish_stream', :display => 'page')
	end

	def set_up_facebook_user(code)
		session[:at] = mogli_client(code).access_token
		user = Mogli::User.find("me",Mogli::Client.new(session[:at]))
		puts "---------------------"
		user_id = User.find_or_create(user)
		session[:current_user_id] = user_id			
	end

	def mogli_client(code)
		Mogli::Client.create_from_code_and_authenticator(code, authenticator)
	end

	def authenticator
		@authenticator ||= Mogli::Authenticator.new('112150088882944', 'ba614b0890c4da8c5d4825a968284222', 'http://localhost:3000/pages/callback')
	end

  protected
  
  def ssl_required?
    Rails.env.production?
  end
  
  def logged_in?
    @current_user
  end

  def current_user
    @current_user ||= User.find(session[:current_user_id])
  end
  
  def searching_delivery?
    session[:order_method] == "Delivery"
  end

end
