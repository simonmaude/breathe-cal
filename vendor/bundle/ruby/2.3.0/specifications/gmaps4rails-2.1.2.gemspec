# -*- encoding: utf-8 -*-
# stub: gmaps4rails 2.1.2 ruby lib

Gem::Specification.new do |s|
  s.name = "gmaps4rails"
  s.version = "2.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Benjamin Roth", "David Ruyer"]
  s.date = "2014-02-17"
  s.description = "Enables easy Google map + overlays creation."
  s.email = ["apnea.diving.deep@gmail.com", "david.ruyer@gmail.com"]
  s.homepage = "http://github.com/apneadiving/Google-Maps-for-Rails"
  s.rubygems_version = "2.5.1"
  s.summary = "Maps made easy for Ruby apps"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["= 2.14.0"])
      s.add_development_dependency(%q<rake>, ["= 10.1.0"])
      s.add_development_dependency(%q<coffee-script>, [">= 0"])
      s.add_development_dependency(%q<sprockets>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["= 2.14.0"])
      s.add_dependency(%q<rake>, ["= 10.1.0"])
      s.add_dependency(%q<coffee-script>, [">= 0"])
      s.add_dependency(%q<sprockets>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["= 2.14.0"])
    s.add_dependency(%q<rake>, ["= 10.1.0"])
    s.add_dependency(%q<coffee-script>, [">= 0"])
    s.add_dependency(%q<sprockets>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
  end
end
