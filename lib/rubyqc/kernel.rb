
module RubyQC
  FixnumMax = 2 ** (0.size * 8 - 2) - 1
  FixnumMin = - FixnumMax - 1
end

module Kernel
  def rubyqc
    self
  end
end

class Array
  def rubyqc
    map(&:rubyqc)
  end
end

class Fixnum
  def self.rubyqc
    rand(RubyQC::FixnumMin..RubyQC::FixnumMax)
  end
end
