# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{acts_as_rateable}
  s.version = "2.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ferenc Fekete", "Gabriel Gironda", "Michael Reinsch"]
  s.date = %q{2009-09-23}
  s.description = %q{Acts_as_rateable is a rails plugin providing a rating interface for ActiveRecord models.}
  s.email = %q{michael@mobalean.com}
  s.extra_rdoc_files = ["README.rdoc", "CHANGELOG.rdoc", "MIT-LICENSE"]
  s.files = ["README.rdoc", "CHANGELOG.rdoc", "MIT-LICENSE", "Rakefile", "init.rb", "rails/init.rb", "lib/rating.rb", "lib/user_rating.rb", "lib/acts_as_rateable.rb", "generators/acts_as_rateable_update1/templates/migration.rb", "generators/acts_as_rateable_update1/acts_as_rateable_update1_generator.rb", "generators/acts_as_rateable_migration/templates/migration.rb", "generators/acts_as_rateable_migration/acts_as_rateable_migration_generator.rb"]
  s.homepage = %q{http://github.com/mreinsch/acts_as_rateable}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Rails plugin providing a rating interface for ActiveRecord models}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
