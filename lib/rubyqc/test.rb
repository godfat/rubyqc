
require 'bacon'
require 'rubyqc'

Bacon.summary_on_exit
Bacon::Context.__send__(:include, RubyQC::API)

RubyQC.default_parallels = 4

module Kernel
  def eq? rhs
    self == rhs
  end
end

class Should
  def self.rubyqc
    new(Class.rubyqc.rubyqc)
  end
end

def verify_generated generated, spec
  if spec.empty?
    generated.should.eq spec
  else
    case spec
    when Array
      verify_array(generated, spec)
    when Hash
      verify_hash(generated, spec)
    else
      verify_other(generated, spec)
    end
  end
end

def verify_array generated, spec
  generated.zip(spec).each do |(instance, expected)|
    case expected
    when Array
      verify_array(instance, expected)
    when Hash
      verify_hash(instance, expected)
    else
      verify_other(instance, expected)
    end
  end
end

def verify_hash generated, spec
  generated.each do |key, instance|
    case expected = spec[key]
    when Array
      verify_array(instance, expected)
    when Hash
      verify_hash(instance, expected)
    else
      verify_other(instance, expected)
    end
  end
end

def verify_other generated, spec
  if spec.kind_of?(Class)
    generated.should.kind_of spec
  else
    generated.should.eq      spec
  end
end
