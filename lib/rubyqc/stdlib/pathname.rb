
require 'pathname'

class Pathname
  def self.rubyqc
    new(File.dirname($LOADED_FEATURES.sample))
  end
end
