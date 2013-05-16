# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ar_merge/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name = "ar_merge"
  gem.summary = "Merge 2 ActiveRecords, preserving associations and attributes"
  gem.authors = ["Michael Grosser"]
  gem.email = "michael@grosser.it"
  gem.homepage = "http://github.com/grosser/ar_merge"
  gem.files = `git ls-files`.split("\n")
  gem.license = "MIT"
  gem.version = ARMerge::VERSION

  gem.add_runtime_dependency "activerecord"
end
