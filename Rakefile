# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require 'terawurfl-client/version'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "terawurfl-client"
  gem.version = TerawurflClient::VERSION
  gem.files = FileList['lib/**/*.rb', '[A-Z]*', 'spec/**/*'].to_a
  gem.homepage = "http://github.com/masv/terawurfl-client"
  gem.license = "MIT"
  gem.summary = %Q{A Tera-WURFL API client for Ruby}
  gem.description = %Q{A Tera-WURFL API client for Ruby}
  gem.email = "martin@saltside.se"
  gem.authors = ["Martin Svangren"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "terawurfl-client #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
