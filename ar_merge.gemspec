$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
name = "ar_merge"
require "#{name}/version"

Gem::Specification.new name, ARMerge::VERSION do |s|
  s.summary = "Merge 2 ActiveRecords, preserving associations and attributes"
  s.authors = ["Michael Grosser"]
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
  s.add_runtime_dependency "activerecord"
end
