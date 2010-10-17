require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "event_horizon"
    gem.summary = %Q{Simple plugin for logging events in Rails applications.}
    gem.description = %Q{TODO: longer description of your gem}
    gem.email = "jzajpt@blueberryapps.com"
    gem.homepage = "http://github.com/jzajpt/event_horizon"
    gem.authors = ["Jiri Zajpt"]
    gem.add_development_dependency "rspec", "~> 2.0.0"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'rspec/core'
require 'rspec/core/rake_task'

Rspec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = "./spec/**/*_spec.rb"
end

Rspec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = "./spec/**/*_spec.rb"
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "event_horizon #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
