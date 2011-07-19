module AdminSection
  def self.included(base)
    base.layout 'admin'
    base.before_filter :require_user
    #base.before_filter :require_admin
  end
  
  def require_admin
    Rails.env.developement? || current_user && current_user.admin? 
  end
end