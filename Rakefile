require 'rubygems'
require 'spec'

desc 'Default: run spec.'
task :default => :spec

desc "Run all specs in spec directory"
task :spec do |t|
  options = "--colour --format progress --loadby --reverse"
  files = FileList['spec/**/*_spec.rb']
  system("spec #{options} #{files}")
end

require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('ar_merge', '0.1.0') do |p|
  p.description    = "Simply and securely merge AciveRecord`s."
  p.url            = "http://github.com/grosser/ar_merge"
  p.author         = "Michael Grosser"
  p.email          = "grosser.michael@gmail.com"
  p.ignore_pattern = ["tmp/*", "script/*"]
  p.dependencies   = %w[activerecord]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }

task :update_gemspec do
  `rake manifest`
  `rake build_gemspec`
end