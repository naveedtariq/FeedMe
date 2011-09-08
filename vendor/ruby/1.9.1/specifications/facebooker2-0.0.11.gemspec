# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{facebooker2}
  s.version = "0.0.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Mike Mangino"]
  s.date = %q{2011-04-01}
  s.description = %q{Facebook Connect integration library for ruby and rails}
  s.email = %q{mmangino@elevatedrails.com}
  s.files = ["lib/facebooker2/rack/post_canvas.rb", "lib/facebooker2/rails/controller.rb", "lib/facebooker2/rails/helpers/facebook_connect.rb", "lib/facebooker2/rails/helpers/javascript.rb", "lib/facebooker2/rails/helpers/request_forms.rb", "lib/facebooker2/rails/helpers/user.rb", "lib/facebooker2/rails/helpers.rb", "lib/facebooker2/rails.rb", "lib/facebooker2.rb"]
  s.homepage = %q{http://developers.facebook.com/docs/api}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Facebook Connect integration library for ruby and rails}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<mogli>, [">= 0.0.12"])
      s.add_runtime_dependency(%q<ruby-hmac>, [">= 0"])
      s.add_development_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_development_dependency(%q<rspec>, ["~> 1.3.1"])
      s.add_development_dependency(%q<rspec-rails>, ["~> 1.3.1"])
      s.add_development_dependency(%q<rails>, ["~> 2.3.10"])
      s.add_development_dependency(%q<json>, ["~> 1.4.0"])
    else
      s.add_dependency(%q<mogli>, [">= 0.0.12"])
      s.add_dependency(%q<ruby-hmac>, [">= 0"])
      s.add_dependency(%q<rake>, ["~> 0.8.7"])
      s.add_dependency(%q<rspec>, ["~> 1.3.1"])
      s.add_dependency(%q<rspec-rails>, ["~> 1.3.1"])
      s.add_dependency(%q<rails>, ["~> 2.3.10"])
      s.add_dependency(%q<json>, ["~> 1.4.0"])
    end
  else
    s.add_dependency(%q<mogli>, [">= 0.0.12"])
    s.add_dependency(%q<ruby-hmac>, [">= 0"])
    s.add_dependency(%q<rake>, ["~> 0.8.7"])
    s.add_dependency(%q<rspec>, ["~> 1.3.1"])
    s.add_dependency(%q<rspec-rails>, ["~> 1.3.1"])
    s.add_dependency(%q<rails>, ["~> 2.3.10"])
    s.add_dependency(%q<json>, ["~> 1.4.0"])
  end
end
