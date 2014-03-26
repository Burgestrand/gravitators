desc "Start the development server on port 5000"
task :server do
  exec "middleman server -p 5000"
end

desc "Run the test suite."
task :spec do
  exec "npm run-script test"
end

task :default => :spec
