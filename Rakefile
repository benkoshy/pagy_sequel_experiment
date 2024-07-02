# Rakefile
# ...
require "rake/testtask"

Rake::TestTask.new do |t|  
  t.test_files = FileList["test/*test.rb"]
  t.verbose = true
  t.name = "basic"
end

task :default => "test:basic"

task "test:basic" => "basic"
