# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ar_merge}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Grosser"]
  s.date = %q{2008-12-22}
  s.description = %q{Simply and securely merge AciveRecord`s.}
  s.email = %q{grosser.michael@gmail.com}
  s.extra_rdoc_files = ["lib/ar_merge.rb", "README.markdown"]
  s.files = ["lib/ar_merge.rb", "spec/setup_test_model.rb", "spec/spec_helper.rb", "spec/ar_merge_spec.rb", "init.rb", "Rakefile", "README.markdown", "Manifest", "ar_merge.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/grosser/ar_merge}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Ar_merge", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ar_merge}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Simply and securely merge AciveRecord`s.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
