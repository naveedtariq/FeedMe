# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{inherited_resources}
  s.version = "1.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["José Valim"]
  s.date = %q{2011-04-17}
  s.description = %q{Inherited Resources speeds up development by making your controllers inherit all restful actions so you just have to focus on what is important.}
  s.email = %q{developers@plataformatec.com.br}
  s.files = [".gitignore", "CHANGELOG", "Gemfile", "Gemfile.lock", "MIT-LICENSE", "README.rdoc", "Rakefile", "inherited_resources.gemspec", "lib/generators/rails/USAGE", "lib/generators/rails/inherited_resources_controller_generator.rb", "lib/generators/rails/templates/controller.rb", "lib/inherited_resources.rb", "lib/inherited_resources/actions.rb", "lib/inherited_resources/base.rb", "lib/inherited_resources/base_helpers.rb", "lib/inherited_resources/belongs_to_helpers.rb", "lib/inherited_resources/blank_slate.rb", "lib/inherited_resources/class_methods.rb", "lib/inherited_resources/dsl.rb", "lib/inherited_resources/polymorphic_helpers.rb", "lib/inherited_resources/responder.rb", "lib/inherited_resources/shallow_helpers.rb", "lib/inherited_resources/singleton_helpers.rb", "lib/inherited_resources/url_helpers.rb", "lib/inherited_resources/version.rb", "test/aliases_test.rb", "test/association_chain_test.rb", "test/base_test.rb", "test/belongs_to_test.rb", "test/belongs_to_with_shallow_test.rb", "test/class_methods_test.rb", "test/customized_base_test.rb", "test/customized_belongs_to_test.rb", "test/customized_redirect_to_test.rb", "test/defaults_test.rb", "test/locales/en.yml", "test/nested_belongs_to_test.rb", "test/nested_belongs_to_with_shallow_test.rb", "test/nested_model_with_shallow_test.rb", "test/optional_belongs_to_test.rb", "test/polymorphic_test.rb", "test/redirect_to_test.rb", "test/singleton_test.rb", "test/test_helper.rb", "test/url_helpers_test.rb", "test/views/cars/edit.html.erb", "test/views/cars/index.html.erb", "test/views/cars/new.html.erb", "test/views/cars/show.html.erb", "test/views/cities/edit.html.erb", "test/views/cities/index.html.erb", "test/views/cities/new.html.erb", "test/views/cities/show.html.erb", "test/views/comments/edit.html.erb", "test/views/comments/index.html.erb", "test/views/comments/new.html.erb", "test/views/comments/show.html.erb", "test/views/educations/new.html.erb", "test/views/employees/edit.html.erb", "test/views/employees/index.html.erb", "test/views/employees/new.html.erb", "test/views/employees/show.html.erb", "test/views/groups/edit.html.erb", "test/views/managers/edit.html.erb", "test/views/managers/new.html.erb", "test/views/managers/show.html.erb", "test/views/painters/edit.html.erb", "test/views/painters/index.html.erb", "test/views/painters/new.html.erb", "test/views/painters/show.html.erb", "test/views/pets/edit.html.erb", "test/views/pets/index.html.erb", "test/views/pets/new.html.erb", "test/views/pets/show.html.erb", "test/views/plates/edit.html.erb", "test/views/plates/index.html.erb", "test/views/plates/new.html.erb", "test/views/plates/show.html.erb", "test/views/products/edit.html.erb", "test/views/products/index.html.erb", "test/views/products/new.html.erb", "test/views/products/show.html.erb", "test/views/professors/edit.html.erb", "test/views/professors/index.html.erb", "test/views/professors/new.html.erb", "test/views/professors/show.html.erb", "test/views/projects/index.html.erb", "test/views/projects/index.json.erb", "test/views/projects/respond_to_skip_default_template.html.erb", "test/views/projects/respond_with_resource.html.erb", "test/views/students/edit.html.erb", "test/views/students/new.html.erb", "test/views/tags/edit.html.erb", "test/views/tags/index.html.erb", "test/views/tags/new.html.erb", "test/views/tags/show.html.erb", "test/views/trees/edit.html.erb", "test/views/trees/index.html.erb", "test/views/trees/new.html.erb", "test/views/trees/show.html.erb", "test/views/university/professors/edit.html.erb", "test/views/university/professors/index.html.erb", "test/views/university/professors/new.html.erb", "test/views/university/professors/show.html.erb", "test/views/users/create.js.erb", "test/views/users/destroy.js.erb", "test/views/users/edit.html.erb", "test/views/users/index.html.erb", "test/views/users/new.html.erb", "test/views/users/show.html.erb", "test/views/users/update.js.erb"]
  s.homepage = %q{http://github.com/josevalim/inherited_resources}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{inherited_resources}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Inherited Resources speeds up development by making your controllers inherit all restful actions so you just have to focus on what is important.}
  s.test_files = ["test/aliases_test.rb", "test/association_chain_test.rb", "test/base_test.rb", "test/belongs_to_test.rb", "test/belongs_to_with_shallow_test.rb", "test/class_methods_test.rb", "test/customized_base_test.rb", "test/customized_belongs_to_test.rb", "test/customized_redirect_to_test.rb", "test/defaults_test.rb", "test/locales/en.yml", "test/nested_belongs_to_test.rb", "test/nested_belongs_to_with_shallow_test.rb", "test/nested_model_with_shallow_test.rb", "test/optional_belongs_to_test.rb", "test/polymorphic_test.rb", "test/redirect_to_test.rb", "test/singleton_test.rb", "test/test_helper.rb", "test/url_helpers_test.rb", "test/views/cars/edit.html.erb", "test/views/cars/index.html.erb", "test/views/cars/new.html.erb", "test/views/cars/show.html.erb", "test/views/cities/edit.html.erb", "test/views/cities/index.html.erb", "test/views/cities/new.html.erb", "test/views/cities/show.html.erb", "test/views/comments/edit.html.erb", "test/views/comments/index.html.erb", "test/views/comments/new.html.erb", "test/views/comments/show.html.erb", "test/views/educations/new.html.erb", "test/views/employees/edit.html.erb", "test/views/employees/index.html.erb", "test/views/employees/new.html.erb", "test/views/employees/show.html.erb", "test/views/groups/edit.html.erb", "test/views/managers/edit.html.erb", "test/views/managers/new.html.erb", "test/views/managers/show.html.erb", "test/views/painters/edit.html.erb", "test/views/painters/index.html.erb", "test/views/painters/new.html.erb", "test/views/painters/show.html.erb", "test/views/pets/edit.html.erb", "test/views/pets/index.html.erb", "test/views/pets/new.html.erb", "test/views/pets/show.html.erb", "test/views/plates/edit.html.erb", "test/views/plates/index.html.erb", "test/views/plates/new.html.erb", "test/views/plates/show.html.erb", "test/views/products/edit.html.erb", "test/views/products/index.html.erb", "test/views/products/new.html.erb", "test/views/products/show.html.erb", "test/views/professors/edit.html.erb", "test/views/professors/index.html.erb", "test/views/professors/new.html.erb", "test/views/professors/show.html.erb", "test/views/projects/index.html.erb", "test/views/projects/index.json.erb", "test/views/projects/respond_to_skip_default_template.html.erb", "test/views/projects/respond_with_resource.html.erb", "test/views/students/edit.html.erb", "test/views/students/new.html.erb", "test/views/tags/edit.html.erb", "test/views/tags/index.html.erb", "test/views/tags/new.html.erb", "test/views/tags/show.html.erb", "test/views/trees/edit.html.erb", "test/views/trees/index.html.erb", "test/views/trees/new.html.erb", "test/views/trees/show.html.erb", "test/views/university/professors/edit.html.erb", "test/views/university/professors/index.html.erb", "test/views/university/professors/new.html.erb", "test/views/university/professors/show.html.erb", "test/views/users/create.js.erb", "test/views/users/destroy.js.erb", "test/views/users/edit.html.erb", "test/views/users/index.html.erb", "test/views/users/new.html.erb", "test/views/users/show.html.erb", "test/views/users/update.js.erb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<responders>, ["~> 0.6.0"])
      s.add_runtime_dependency(%q<has_scope>, ["~> 0.5.0"])
    else
      s.add_dependency(%q<responders>, ["~> 0.6.0"])
      s.add_dependency(%q<has_scope>, ["~> 0.5.0"])
    end
  else
    s.add_dependency(%q<responders>, ["~> 0.6.0"])
    s.add_dependency(%q<has_scope>, ["~> 0.5.0"])
  end
end
