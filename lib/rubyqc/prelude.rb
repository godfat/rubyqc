
module RubyQC
  FixnumMax = 2 ** (0.size * 8 - 2) - 1
  FixnumMin = - FixnumMax - 1
  FixnumSuc = FixnumMax + 1
  BignumMax = FixnumMax * 10
  BignumMin = FixnumMin * 10
end

module Kernel
  def rubyqc
    self
  end
end

class Class
  def rubyqc
    new
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

class Bignum
  def self.rubyqc
    case rand(2)
    when 0
      rand(RubyQC::BignumMin...RubyQC::FixnumMin)
    when 1
      rand(RubyQC::FixnumSuc...RubyQC::BignumMax)
    else
      raise "huh?"
    end
  end
end
