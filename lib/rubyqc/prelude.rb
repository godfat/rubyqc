
module RubyQC
  big = 2 ** (0.size * 8 - 2)
  FixnumMax = if big.kind_of?(Bignum)
                big - 1
              else # probably jruby...
                2 ** (0.size * 8 - 1) - 1
              end
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
  rescue => e
    warn "Cannot new #{self}: #{e}"
    raise
  end
end

###
### class level implementation
###

class NilClass
  def self.rubyqc
    nil
  end
end

class TrueClass
  def self.rubyqc
    true
  end
end

class FalseClass
  def self.rubyqc
    false
  end
end

class Proc
  def self.rubyqc
    lambda{ Class.rubyqc.rubyqc }
  end
end

class Method
  def self.rubyqc
    obj = Class.rubyqc.rubyqc
    obj.method(obj.methods.sample)
  end
end

class UnboundMethod
  def self.rubyqc
    klass = Class.rubyqc
    klass.instance_method(klass.instance_methods.sample)
  end
end

class Binding
  def self.rubyqc
    binding
  end
end

class Symbol
  def self.rubyqc
    all_symbols.sample
  end
end

class Encoding
  def self.rubyqc
    list.sample
  end
end

class Dir
  def self.rubyqc
    Dir.open(File.dirname($LOADED_FEATURES.sample))
  end
end

class File
  def self.rubyqc
    File.open($LOADED_FEATURES.sample)
  rescue Errno::ENOENT # e.g. thread.rb, enumerator.so
    File.open(__FILE__)
  end
end

class IO
  def self.rubyqc
    pipe.sample
  end
end

# TODO
class String
  def self.rubyqc
    /.*/.rubyqc
  end
end

class Regexp
  def self.rubyqc
    new(String.rubyqc)
  end
end

class MatchData
  def self.rubyqc
    String.rubyqc.match(Regexp.rubyqc)
  end
end

class Class
  def self.rubyqc
    Object.constants.map{ |name|                 # rubinius # jruby
      if ![:BasicObject, :Class, :Config, :Data, :Autoload, :Continuation,
           :RubyVM, :Struct, :WeakRef, :TracePoint].include?(name) &&
         name !~ /Java/
        const_get(name)
      end
    }.select{ |const| const.kind_of?(Class) }.sample
  end
end

# TODO: why?
# class Object
#   def self.rubyqc
#     Class.rubyqc.rubyqc
#   end
# end

class Fixnum
  def self.rubyqc
    (RubyQC::FixnumMin..RubyQC::FixnumMax).rubyqc
  end
end

class Bignum
  def self.rubyqc
    case (0..1).rubyqc
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
    [Bignum, Fixnum].sample.rubyqc
  end
end

class Complex
  def self.rubyqc
    Fixnum.rubyqc + Fixnum.rubyqc.i
  end
end

class Rational
  def self.rubyqc
    Rational(Fixnum.rubyqc, Fixnum.rubyqc)
  end
end

class Range
  def self.rubyqc
    new(*[Fixnum.rubyqc, Fixnum.rubyqc].sort)
  end
end

class Enumerator
  def self.rubyqc
    Array.rubyqc.to_enum
  end
end

# TODO
class Float
  def self.rubyqc
    rand
  end
end

class Fiber
  def self.rubyqc
    new(&Proc.rubyqc)
  end
end

class Thread
  def self.rubyqc
    new(&Proc.rubyqc)
  end
end

class SizedQueue
  def self.rubyqc
    new(rand(1..100))
  end
end

class SignalException
  def self.rubyqc
    new(rand(0..31))
  end
end

class SystemCallError
  def self.rubyqc
    new(rand(1..106))
  end
end

class Struct
  def self.rubyqc
    new(Symbol.rubyqc)
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

class Proc
  def rubyqc
    call
  end
end

# TODO
class Regexp
  def rubyqc
    'rubyqc...'
  end
end
