require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['spec/smoke/*.rb']
  t.verbose = true
end
