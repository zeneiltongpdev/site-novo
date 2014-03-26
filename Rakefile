require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new(:spec)
task :test => :spec

desc 'Import data from local drupal to Jekyll project'
task :import do
  require_relative 'lib/import.rb' 
  JekyllImport::Importers::Drupal6.run({
    "dbname"   => "mst2",
    "user"     => "root",
    "password" => "root",
    "host"     => "localhost",
    "prefix"   => ""
  })
end
