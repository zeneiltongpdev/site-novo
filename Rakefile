require 'rspec/core/rake_task'
require 'rake/testtask'

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

Rake::TestTask.new("test:unit") do |t|
  t.libs << "test"
  t.test_files = FileList['test/unit/**/*.rb']
  t.verbose = true
end
