# -*- encoding: utf-8 -*-
# stub: rubyqc 0.0.1 ruby lib

Gem::Specification.new do |s|
  s.name = "rubyqc"
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Lin Jen-Shin (godfat)"]
  s.date = "2014-01-30"
  s.description = "RubyQC -- A conceptual [QuickCheck][] library for Ruby.\n\nIt's not a faithful port since Hsakell is totally different than Ruby.\nHowever it's still benefit to use some of the ideas behind QuickCheck,\nand we could also use RubyQC for generating arbitrary objects.\n\n[QuickCheck]: http://en.wikipedia.org/wiki/QuickCheck"
  s.email = ["godfat (XD) godfat.org"]
  s.files = [
  ".gitignore",
  ".gitmodules",
  ".travis.yml",
  "Gemfile",
  "LICENSE",
  "README.md",
  "Rakefile",
  "lib/rubyqc.rb",
  "lib/rubyqc/modifier.rb",
  "lib/rubyqc/prelude.rb",
  "lib/rubyqc/test.rb",
  "lib/rubyqc/version.rb",
  "rubyqc.gemspec",
  "task/README.md",
  "task/gemgem.rb",
  "test/test_api.rb",
  "test/test_kind_of.rb",
  "test/test_readme.rb"]
  s.homepage = "https://github.com/godfat/rubyqc"
  s.licenses = ["Apache License 2.0"]
  s.rubygems_version = "2.2.1"
  s.summary = "RubyQC -- A conceptual [QuickCheck][] library for Ruby."
  s.test_files = [
  "test/test_api.rb",
  "test/test_kind_of.rb",
  "test/test_readme.rb"]
end
