module ActionView::Helpers::UrlHelper
  
  def link_to_with_fb_gouri(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      concat(link_to(capture(&block), options, html_options))
    else
      name         = args.first
      options      = args.second || {}
      html_options = args.third
      
      url = url_for(options)
      
      link_to_without_fb_gouri(name, options, html_options.merge(:onclick => url))
    end    
  end
  alias_method_chain :link_to, :fb_gouri
  
end