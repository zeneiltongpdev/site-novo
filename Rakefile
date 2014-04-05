n = namespace :test do
  require 'rake/testtask'

  Rake::TestTask.new(:smoke) do |t|
    t.pattern = 'test/smoke/*_test.rb'
    t.verbose = false
    t.warning = false
  end
end

task :test => [ n[:smoke]]
task :default => :test
