# -*- encoding: utf-8 -*-
# stub: rubyqc 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rubyqc".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Lin Jen-Shin (godfat)".freeze]
  s.date = "2016-03-03"
  s.description = "RubyQC -- A conceptual [QuickCheck][] library for Ruby.\n\nIt's not a faithful port since Hsakell is totally different than Ruby.\nHowever it's still benefit to use some of the ideas behind QuickCheck,\nand we could also use RubyQC for generating arbitrary objects.\n\n[QuickCheck]: http://en.wikipedia.org/wiki/QuickCheck".freeze
  s.email = ["godfat (XD) godfat.org".freeze]
  s.files = [
  ".gitignore".freeze,
  ".gitmodules".freeze,
  ".travis.yml".freeze,
  "CHANGES.md".freeze,
  "Gemfile".freeze,
  "LICENSE".freeze,
  "README.md".freeze,
  "Rakefile".freeze,
  "lib/rubyqc.rb".freeze,
  "lib/rubyqc/all.rb".freeze,
  "lib/rubyqc/api.rb".freeze,
  "lib/rubyqc/error.rb".freeze,
  "lib/rubyqc/modifier.rb".freeze,
  "lib/rubyqc/prelude.rb".freeze,
  "lib/rubyqc/stdlib.rb".freeze,
  "lib/rubyqc/stdlib/delegate.rb".freeze,
  "lib/rubyqc/stdlib/pathname.rb".freeze,
  "lib/rubyqc/stdlib/socket.rb".freeze,
  "lib/rubyqc/stdlib/stringio.rb".freeze,
  "lib/rubyqc/stdlib/strscan.rb".freeze,
  "lib/rubyqc/stdlib/tempfile.rb".freeze,
  "lib/rubyqc/stdlib/weakref.rb".freeze,
  "lib/rubyqc/test.rb".freeze,
  "lib/rubyqc/version.rb".freeze,
  "rubyqc.gemspec".freeze,
  "task/README.md".freeze,
  "task/gemgem.rb".freeze,
  "test/test_api.rb".freeze,
  "test/test_modifier.rb".freeze,
  "test/test_prelude.rb".freeze,
  "test/test_readme.rb".freeze]
  s.homepage = "https://github.com/godfat/rubyqc".freeze
  s.licenses = ["Apache License 2.0".freeze]
  s.rubygems_version = "2.6.1".freeze
  s.summary = "RubyQC -- A conceptual [QuickCheck][] library for Ruby.".freeze
  s.test_files = [
  "test/test_api.rb".freeze,
  "test/test_modifier.rb".freeze,
  "test/test_prelude.rb".freeze,
  "test/test_readme.rb".freeze]
end
