require 'rspec/core/rake_task'


RSpec::Core::RakeTask.new(:spec)
task :test => :spec

desc 'Import data from local drupal to Jekyll project'
task :import do
  require_relative 'lib/import.rb' 
  JekyllImport::Importers::Drupal6.run({
    "dbname"   => ENV['DBNAME'] || 'mst2',
    "user"     => ENV['USER'] || 'root',
    "password" => ENV['PASSWORD'] || 'root',
    "host"     => ENV['HOST'] || 'localhost',
    "prefix"   => ""
  })
end
