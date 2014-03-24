require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/*.rb']
  t.verbose = true
end

desc 'Import data from local drupal to Jekyll project'
task :import do
  require_relative 'lib/import.rb' 
  JekyllImport::Importers::Drupal6.run({
    "dbname"   => "mst2",
    "user"     => "root",
    "password" => "",
    "host"     => "localhost",
    "prefix"   => ""
  })
end
