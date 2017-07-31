# -*- encoding: utf-8 -*-
# stub: cucumber-rails-training-wheels 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-rails-training-wheels"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Aslak Helles\u{f8}y"]
  s.date = "2011-10-05"
  s.description = "Training Wheels for Cucumber-Rails"
  s.email = "cukes@googlegroups.com"
  s.homepage = "http://cukes.info"
  s.rubygems_version = "2.5.1"
  s.summary = "cucumber-rails-training-wheels-1.0.0"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<cucumber-rails>, [">= 1.1.1"])
      s.add_development_dependency(%q<rails>, [">= 3.1.0"])
      s.add_development_dependency(%q<aruba>, [">= 0.4.6"])
      s.add_development_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_development_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.6.7"])
    else
      s.add_dependency(%q<cucumber-rails>, [">= 1.1.1"])
      s.add_dependency(%q<rails>, [">= 3.1.0"])
      s.add_dependency(%q<aruba>, [">= 0.4.6"])
      s.add_dependency(%q<rspec>, [">= 2.6.0"])
      s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
      s.add_dependency(%q<database_cleaner>, [">= 0.6.7"])
    end
  else
    s.add_dependency(%q<cucumber-rails>, [">= 1.1.1"])
    s.add_dependency(%q<rails>, [">= 3.1.0"])
    s.add_dependency(%q<aruba>, [">= 0.4.6"])
    s.add_dependency(%q<rspec>, [">= 2.6.0"])
    s.add_dependency(%q<rspec-rails>, [">= 2.6.1"])
    s.add_dependency(%q<database_cleaner>, [">= 0.6.7"])
  end
end
