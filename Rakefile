require "bundler/gem_tasks"
require 'yard'
require 'yard/rake/yardoc_task'

task :default => :spec

YARD::Rake::YardocTask.new do |t|
  t.files = %w(lib/*.rb lib/**/*.rb)
  t.options = []
  t.options = %w(--debug --verbose) if $trace
end