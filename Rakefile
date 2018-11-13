begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rdoc/task'

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'TopologicalInventory'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

load 'rails/tasks/statistics.rake'

require 'bundler/gem_tasks'
require "rspec/core/rake_task"

require "active_record"
require "yaml"

load "active_record/railties/databases.rake"

namespace :db do
  task :environment do
    require "topological_inventory/persister/ar_helper"
    TopologicalInventory::Persister::ArHelper.load_environment!
  end
  Rake::Task["db:load_config"].enhance(["db:environment"])
end

# Spec related rake tasks
RSpec::Core::RakeTask.new(:spec)

namespace :spec do
  task :initialize do
    ENV["RAILS_ENV"] ||= "test"
  end

  desc "Setup the database for running tests"
  task :setup => [:initialize, "db:test:prepare"]
end

task default: :spec
