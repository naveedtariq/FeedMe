# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{efax}
  s.version = "1.3.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Szymon Nowak", "Pawel Kozlowski", "Dr Nic Williams"]
  s.date = %q{2010-03-17}
  s.email = %q{szimek@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = [".gitignore", "README.rdoc", "Rakefile", "VERSION", "efax.gemspec", "lib/efax.rb", "lib/efax/helpers/inbound_helpers.rb", "lib/efax/inbound.rb", "lib/efax/outbound.rb", "test/efax_inbound_test.rb", "test/efax_outbound_test.rb", "test/test_helper.rb"]
  s.homepage = %q{http://github.com/szimek/efax}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{efax}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Ruby library for accessing the eFax Developer service}
  s.test_files = ["test/efax_inbound_test.rb", "test/efax_outbound_test.rb", "test/test_helper.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<hpricot>, [">= 0.8.1"])
      s.add_development_dependency(%q<test-unit>, ["~> 2"])
      s.add_development_dependency(%q<mocha>, [">= 0.9"])
    else
      s.add_dependency(%q<hpricot>, [">= 0.8.1"])
      s.add_dependency(%q<test-unit>, ["~> 2"])
      s.add_dependency(%q<mocha>, [">= 0.9"])
    end
  else
    s.add_dependency(%q<hpricot>, [">= 0.8.1"])
    s.add_dependency(%q<test-unit>, ["~> 2"])
    s.add_dependency(%q<mocha>, [">= 0.9"])
  end
end
