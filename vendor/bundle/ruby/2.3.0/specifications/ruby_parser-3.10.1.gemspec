# -*- encoding: utf-8 -*-
# stub: ruby_parser 3.10.1 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby_parser"
  s.version = "3.10.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ryan Davis"]
  s.cert_chain = ["-----BEGIN CERTIFICATE-----\nMIIDijCCAnKgAwIBAgIBATANBgkqhkiG9w0BAQUFADBFMRMwEQYDVQQDDApyeWFu\nZC1ydWJ5MRkwFwYKCZImiZPyLGQBGRYJemVuc3BpZGVyMRMwEQYKCZImiZPyLGQB\nGRYDY29tMB4XDTE2MDkyNjAxNTczNVoXDTE3MDkyNjAxNTczNVowRTETMBEGA1UE\nAwwKcnlhbmQtcnVieTEZMBcGCgmSJomT8ixkARkWCXplbnNwaWRlcjETMBEGCgmS\nJomT8ixkARkWA2NvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALda\nb9DCgK+627gPJkB6XfjZ1itoOQvpqH1EXScSaba9/S2VF22VYQbXU1xQXL/WzCkx\ntaCPaLmfYIaFcHHCSY4hYDJijRQkLxPeB3xbOfzfLoBDbjvx5JxgJxUjmGa7xhcT\noOvjtt5P8+GSK9zLzxQP0gVLS/D0FmoE44XuDr3iQkVS2ujU5zZL84mMNqNB1znh\nGiadM9GHRaDiaxuX0cIUBj19T01mVE2iymf9I6bEsiayK/n6QujtyCbTWsAS9Rqt\nqhtV7HJxNKuPj/JFH0D2cswvzznE/a5FOYO68g+YCuFi5L8wZuuM8zzdwjrWHqSV\ngBEfoTEGr7Zii72cx+sCAwEAAaOBhDCBgTAJBgNVHRMEAjAAMAsGA1UdDwQEAwIE\nsDAdBgNVHQ4EFgQUR8V72Z3+v+2P9abCnL4wjx32T+EwIwYDVR0RBBwwGoEYcnlh\nbmQtcnVieUB6ZW5zcGlkZXIuY29tMCMGA1UdEgQcMBqBGHJ5YW5kLXJ1YnlAemVu\nc3BpZGVyLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAIGzgp0aZ2W9+v96ujmBcQHoC\nbuy0iU68MVj2VlxMyfr1KPZIh1OyhU4UO4zrkREcH8ML70v9cYHNvOd9oynRHnvC\nl2tj/fD3YJ0AEkJxGrYwRWQmvMfC4bJ02bC1+rVOUIXXKp3+cUmiN4sTniof8VFo\nbo/YYP4c7erpERa+9hrqygg6WQbJlk2YRlH3JXPFjmu869i2dcbR5ZLOAeEy+axH\nE4oJcnPkJAr0rw504JGtlZtONZQblwmRJOIdXzolaE3NRGUzGVOUSptZppAKiavY\nfO6tdKQc/5RfA8oQEkg8hrxA5PQSz4TOFJGLpFvIapEk6tMruQ0bHgkhr9auXg==\n-----END CERTIFICATE-----\n"]
  s.date = "2017-07-21"
  s.description = "ruby_parser (RP) is a ruby parser written in pure ruby (utilizing\nracc--which does by default use a C extension). RP's output is\nthe same as ParseTree's output: s-expressions using ruby's arrays and\nbase types.\n\nAs an example:\n\n    def conditional1 arg1\n      return 1 if arg1 == 0\n      return 0\n    end\n\nbecomes:\n\n    s(:defn, :conditional1, s(:args, :arg1),\n      s(:if,\n        s(:call, s(:lvar, :arg1), :==, s(:lit, 0)),\n        s(:return, s(:lit, 1)),\n        nil),\n      s(:return, s(:lit, 0)))\n\nTested against 801,039 files from the latest of all rubygems (as of 2013-05):\n\n* 1.8 parser is at 99.9739% accuracy, 3.651 sigma\n* 1.9 parser is at 99.9940% accuracy, 4.013 sigma\n* 2.0 parser is at 99.9939% accuracy, 4.008 sigma"
  s.email = ["ryand-ruby@zenspider.com"]
  s.executables = ["ruby_parse", "ruby_parse_extract_error"]
  s.extra_rdoc_files = ["History.rdoc", "Manifest.txt", "README.rdoc"]
  s.files = ["History.rdoc", "Manifest.txt", "README.rdoc", "bin/ruby_parse", "bin/ruby_parse_extract_error"]
  s.homepage = "https://github.com/seattlerb/ruby_parser"
  s.licenses = ["MIT"]
  s.rdoc_options = ["--main", "README.rdoc"]
  s.rubygems_version = "2.5.1"
  s.summary = "ruby_parser (RP) is a ruby parser written in pure ruby (utilizing racc--which does by default use a C extension)"

  s.installed_by_version = "2.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sexp_processor>, ["~> 4.9"])
      s.add_development_dependency(%q<rake>, ["< 11"])
      s.add_development_dependency(%q<oedipus_lex>, ["~> 2.5"])
      s.add_development_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_development_dependency(%q<racc>, ["~> 1.4.6"])
      s.add_development_dependency(%q<hoe>, ["~> 3.16"])
    else
      s.add_dependency(%q<sexp_processor>, ["~> 4.9"])
      s.add_dependency(%q<rake>, ["< 11"])
      s.add_dependency(%q<oedipus_lex>, ["~> 2.5"])
      s.add_dependency(%q<rdoc>, ["~> 4.0"])
      s.add_dependency(%q<racc>, ["~> 1.4.6"])
      s.add_dependency(%q<hoe>, ["~> 3.16"])
    end
  else
    s.add_dependency(%q<sexp_processor>, ["~> 4.9"])
    s.add_dependency(%q<rake>, ["< 11"])
    s.add_dependency(%q<oedipus_lex>, ["~> 2.5"])
    s.add_dependency(%q<rdoc>, ["~> 4.0"])
    s.add_dependency(%q<racc>, ["~> 1.4.6"])
    s.add_dependency(%q<hoe>, ["~> 3.16"])
  end
end
