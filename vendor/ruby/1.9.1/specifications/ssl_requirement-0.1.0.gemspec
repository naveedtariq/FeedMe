# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ssl_requirement}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["David Heinemeier Hansson"]
  s.date = %q{2010-01-12}
  s.description = %q{SSL requirement adds a declarative way of specifying that certain actions should only be allowed to run under SSL, and if they're accessed without it, they should be redirected.}
  s.email = %q{david@loudthinking.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README", "lib/ssl_requirement.rb", "test/ssl_requirement_test.rb"]
  s.homepage = %q{http://github.com/rails/ssl_requirement}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{SSL Requirement plugin}
  s.test_files = ["test/ssl_requirement_test.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
