# -*- encoding: utf-8 -*-
# stub: codeclimate-test-reporter 1.0.8 ruby lib

Gem::Specification.new do |s|
  s.name = "codeclimate-test-reporter"
  s.version = "1.0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Bryan Helmkamp", "Code Climate"]
  s.date = "2017-03-20"
  s.description = "Collects test coverage data from your Ruby test suite and sends it to Code Climate's hosted, automated code review service. Based on SimpleCov."
  s.email = ["bryan@brynary.com", "hello@codeclimate.com"]
  s.executables = ["cc-tddium-post-worker", "codeclimate-test-reporter"]
  s.files = ["bin/cc-tddium-post-worker", "bin/codeclimate-test-reporter"]
  s.homepage = "https://github.com/codeclimate/ruby-test-reporter"
  s.licenses = ["MIT"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9")
  s.rubygems_version = "2.5.1"
  s.summary = "Uploads Ruby test coverage data to Code Climate."

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<simplecov>, ["<= 0.13"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
    else
      s.add_dependency(%q<simplecov>, ["<= 0.13"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
    end
  else
    s.add_dependency(%q<simplecov>, ["<= 0.13"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
  end
end
