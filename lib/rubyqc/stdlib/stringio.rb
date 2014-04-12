
require 'stringio'

class StringIO
  def self.rubyqc
    new(String.rubyqc)
  end
end
