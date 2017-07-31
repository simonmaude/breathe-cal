# -*- encoding: utf-8 -*-
# stub: cucumber-rails 1.5.0 ruby lib

Gem::Specification.new do |s|
  s.name = "cucumber-rails"
  s.version = "1.5.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Aslak Helles\u{f8}y", "Dennis Bl\u{f6}te", "Rob Holland"]
  s.date = "2017-05-12"
  s.description = "Cucumber Generator and Runtime for Rails"
  s.email = "cukes@googlegroups.com"
  s.homepage = "http://cukes.info"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "cucumber-rails-1.5.0"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<capybara>, ["< 3", ">= 1.1.2"])
      s.add_runtime_dependency(%q<cucumber>, ["< 4", ">= 1.3.8"])
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.5"])
      s.add_runtime_dependency(%q<railties>, ["< 5.2", ">= 4"])
      s.add_runtime_dependency(%q<mime-types>, ["< 4", ">= 1.17"])
      s.add_development_dependency(%q<ammeter>, ["< 1.1.3", ">= 1.0.0"])
      s.add_development_dependency(%q<appraisal>, [">= 0.5.1"])
      s.add_development_dependency(%q<aruba>, ["~> 0.14.2"])
      s.add_development_dependency(%q<builder>, ["< 4", ">= 3.1.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.3.5"])
      s.add_development_dependency(%q<selenium-webdriver>, [">= 2.45.0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 1.0.0"])
      s.add_development_dependency(%q<factory_girl>, [">= 3.2"])
      s.add_development_dependency(%q<rake>, [">= 0.9.2.2"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rails>, [">= 0"])
      s.add_development_dependency(%q<rdiscount>, [">= 2.0.7"])
      s.add_development_dependency(%q<rdoc>, [">= 3.4"])
      s.add_development_dependency(%q<yard>, [">= 0.8.7"])
    else
      s.add_dependency(%q<capybara>, ["< 3", ">= 1.1.2"])
      s.add_dependency(%q<cucumber>, ["< 4", ">= 1.3.8"])
      s.add_dependency(%q<nokogiri>, ["~> 1.5"])
      s.add_dependency(%q<railties>, ["< 5.2", ">= 4"])
      s.add_dependency(%q<mime-types>, ["< 4", ">= 1.17"])
      s.add_dependency(%q<ammeter>, ["< 1.1.3", ">= 1.0.0"])
      s.add_dependency(%q<appraisal>, [">= 0.5.1"])
      s.add_dependency(%q<aruba>, ["~> 0.14.2"])
      s.add_dependency(%q<builder>, ["< 4", ">= 3.1.0"])
      s.add_dependency(%q<bundler>, [">= 1.3.5"])
      s.add_dependency(%q<selenium-webdriver>, [">= 2.45.0"])
      s.add_dependency(%q<database_cleaner>, [">= 1.0.0"])
      s.add_dependency(%q<factory_girl>, [">= 3.2"])
      s.add_dependency(%q<rake>, [">= 0.9.2.2"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rails>, [">= 0"])
      s.add_dependency(%q<rdiscount>, [">= 2.0.7"])
      s.add_dependency(%q<rdoc>, [">= 3.4"])
      s.add_dependency(%q<yard>, [">= 0.8.7"])
    end
  else
    s.add_dependency(%q<capybara>, ["< 3", ">= 1.1.2"])
    s.add_dependency(%q<cucumber>, ["< 4", ">= 1.3.8"])
    s.add_dependency(%q<nokogiri>, ["~> 1.5"])
    s.add_dependency(%q<railties>, ["< 5.2", ">= 4"])
    s.add_dependency(%q<mime-types>, ["< 4", ">= 1.17"])
    s.add_dependency(%q<ammeter>, ["< 1.1.3", ">= 1.0.0"])
    s.add_dependency(%q<appraisal>, [">= 0.5.1"])
    s.add_dependency(%q<aruba>, ["~> 0.14.2"])
    s.add_dependency(%q<builder>, ["< 4", ">= 3.1.0"])
    s.add_dependency(%q<bundler>, [">= 1.3.5"])
    s.add_dependency(%q<selenium-webdriver>, [">= 2.45.0"])
    s.add_dependency(%q<database_cleaner>, [">= 1.0.0"])
    s.add_dependency(%q<factory_girl>, [">= 3.2"])
    s.add_dependency(%q<rake>, [">= 0.9.2.2"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rails>, [">= 0"])
    s.add_dependency(%q<rdiscount>, [">= 2.0.7"])
    s.add_dependency(%q<rdoc>, [">= 3.4"])
    s.add_dependency(%q<yard>, [">= 0.8.7"])
  end
end
