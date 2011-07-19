module PublicSection
  
  def self.included(base)
    base.geocode_ip_address
    base.before_filter :set_p3p
    base.before_filter :safari_cookie_fix
    # base.before_filter :redirect_non_facebook_safari_requests
    base.before_filter :ensure_authenticated
	
    # # base.before_filter :ensure_application_is_installed_by_facebook_user    
    # base.before_filter :set_facebook_session
    # base.before_filter :require_facebook_user
    #base.before_filter :require_user
    base.helper_method :current_location
    base.helper_method :pending_order_at    
    base.before_filter :require_location
  end
  
  
  
  protected
  
  
  # 
  # def require_facebook_user
  #   current_user
  # end
  # 
  # def current_user
  #   @current_user ||= User.find_or_create_by_facebook_uid(:facebook_uid => facebook_session.user.id)
  # end
  # 
  
  def redirect_non_facebook_safari_requests
    redirect_to welcome_path if !cookies['safari_cookie_fix'] && request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/Safari/] && request.referer !~ /\/welcome/
  end
  
  def set_p3p
   response.headers["P3P"]='CP="CAO PSA OUR"'
  end
  
  def safari_cookie_fix
    cookies['safari_cookie_fix'] = 'cookie OK'
  end
  
  def current_location
  	current_user.locations.find(:first, :conditions => "active = 1") || current_user.locations.find(:first) || Location.new
  end
  
  def pending_order_at(restaurant)
    current_user.orders.pending_at(restaurant).find(:first) || current_user.orders.create(:restaurant => restaurant)
  end
  
  def require_location
    top_redirect_to new_location_path(:auth_token => params[:auth_token]) unless current_location && current_location.lat && current_location.lng
  end
  # 
  # def logged_in?
  #   facebook_session
  # end

end
