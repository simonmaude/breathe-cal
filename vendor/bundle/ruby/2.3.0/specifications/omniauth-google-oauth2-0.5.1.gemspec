# -*- encoding: utf-8 -*-
# stub: omniauth-google-oauth2 0.5.1 ruby lib

Gem::Specification.new do |s|
  s.name = "omniauth-google-oauth2"
  s.version = "0.5.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Josh Ellithorpe", "Yury Korolev"]
  s.date = "2017-07-20"
  s.description = "A Google OAuth2 strategy for OmniAuth 1.x. This allows you to login to Google with your ruby app."
  s.email = ["quest@mac.com"]
  s.homepage = "https://github.com/zquestz/omniauth-google-oauth2"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 2.0")
  s.rubygems_version = "2.5.1"
  s.summary = "A Google OAuth2 strategy for OmniAuth 1.x"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<omniauth>, [">= 1.1.1"])
      s.add_runtime_dependency(%q<omniauth-oauth2>, [">= 1.3.1"])
      s.add_runtime_dependency(%q<jwt>, ["~> 1.5"])
      s.add_runtime_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_development_dependency(%q<rspec>, ["~> 3.6"])
      s.add_development_dependency(%q<rake>, ["~> 12.0"])
      s.add_development_dependency(%q<rubocop>, ["~> 0.49"])
    else
      s.add_dependency(%q<omniauth>, [">= 1.1.1"])
      s.add_dependency(%q<omniauth-oauth2>, [">= 1.3.1"])
      s.add_dependency(%q<jwt>, ["~> 1.5"])
      s.add_dependency(%q<multi_json>, ["~> 1.3"])
      s.add_dependency(%q<rspec>, ["~> 3.6"])
      s.add_dependency(%q<rake>, ["~> 12.0"])
      s.add_dependency(%q<rubocop>, ["~> 0.49"])
    end
  else
    s.add_dependency(%q<omniauth>, [">= 1.1.1"])
    s.add_dependency(%q<omniauth-oauth2>, [">= 1.3.1"])
    s.add_dependency(%q<jwt>, ["~> 1.5"])
    s.add_dependency(%q<multi_json>, ["~> 1.3"])
    s.add_dependency(%q<rspec>, ["~> 3.6"])
    s.add_dependency(%q<rake>, ["~> 12.0"])
    s.add_dependency(%q<rubocop>, ["~> 0.49"])
  end
end
