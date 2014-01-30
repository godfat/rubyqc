
module RubyQC
  FixnumMax = 2 ** (0.size * 8 - 2) - 1
  FixnumMin = - FixnumMax - 1
  FixnumSuc = FixnumMax + 1
  BignumMax = FixnumMax * 10
  BignumMin = FixnumMin * 10
end

###
### default implementation
###

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

###
### class level implementation
###

class Fixnum
  def self.rubyqc
    (RubyQC::FixnumMin..RubyQC::FixnumMax).rubyqc
  end
end

class Bignum
  def self.rubyqc
    case rand(2)
    when 0
      (RubyQC::BignumMin...RubyQC::FixnumMin).rubyqc
    when 1
      (RubyQC::FixnumSuc...RubyQC::BignumMax).rubyqc
    else
      raise "huh?"
    end
  end
end

class Integer
  def self.rubyqc
    RubyQC::API.one_of(Bignum, Fixnum).rubyqc
  end
end

###
### instance level implementation
###

class Array
  def rubyqc
    map(&:rubyqc)
  end
end

class Hash
  def rubyqc
    inject({}){ |r, (k, v)| r[k] = v.rubyqc; r }
  end
end

class Range
  def rubyqc
    rand(self.begin..self.end)
  end
end
