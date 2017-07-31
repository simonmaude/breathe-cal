# -*- encoding: utf-8 -*-
# stub: main 6.2.2 ruby lib

Gem::Specification.new do |s|
  s.name = "main"
  s.version = "6.2.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ara T. Howard"]
  s.date = "2017-01-20"
  s.description = "a class factory and dsl for generating command line programs real quick"
  s.email = "ara.t.howard@gmail.com"
  s.homepage = "https://github.com/ahoward/main"
  s.licenses = ["Ruby"]
  s.rubyforge_project = "codeforpeople"
  s.rubygems_version = "2.5.1"
  s.summary = "main"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<chronic>, [">= 0.6.2", "~> 0.6"])
      s.add_runtime_dependency(%q<fattr>, [">= 2.2.0", "~> 2.2"])
      s.add_runtime_dependency(%q<arrayfields>, [">= 4.7.4", "~> 4.7"])
      s.add_runtime_dependency(%q<map>, [">= 6.1.0", "~> 6.1"])
    else
      s.add_dependency(%q<chronic>, [">= 0.6.2", "~> 0.6"])
      s.add_dependency(%q<fattr>, [">= 2.2.0", "~> 2.2"])
      s.add_dependency(%q<arrayfields>, [">= 4.7.4", "~> 4.7"])
      s.add_dependency(%q<map>, [">= 6.1.0", "~> 6.1"])
    end
  else
    s.add_dependency(%q<chronic>, [">= 0.6.2", "~> 0.6"])
    s.add_dependency(%q<fattr>, [">= 2.2.0", "~> 2.2"])
    s.add_dependency(%q<arrayfields>, [">= 4.7.4", "~> 4.7"])
    s.add_dependency(%q<map>, [">= 6.1.0", "~> 6.1"])
  end
end
