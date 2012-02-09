# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "terawurfl-client"
  s.version = "0.2.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Svangren"]
  s.date = "2012-02-09"
  s.description = "A Tera-WURFL API client for Ruby"
  s.email = "martin@saltside.se"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "lib/terawurfl-client.rb",
    "lib/terawurfl-client/config.rb",
    "lib/terawurfl-client/device.rb",
    "lib/terawurfl-client/mock.rb",
    "lib/terawurfl-client/version.rb",
    "spec/spec_helper.rb",
    "spec/terawurfl-client_spec.rb",
    "spec/wurfl-response.txt"
  ]
  s.homepage = "http://github.com/masv/terawurfl-client"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "A Tera-WURFL API client for Ruby"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_runtime_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_development_dependency(%q<fakeweb>, ["~> 1.3.0"])
    else
      s.add_dependency(%q<activesupport>, [">= 2.3.5"])
      s.add_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
      s.add_dependency(%q<rspec>, ["~> 2.8.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
      s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 2.3.5"])
    s.add_dependency(%q<yajl-ruby>, ["~> 1.1.0"])
    s.add_dependency(%q<rspec>, ["~> 2.8.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.3"])
    s.add_dependency(%q<fakeweb>, ["~> 1.3.0"])
  end
end

