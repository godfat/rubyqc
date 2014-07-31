
require 'pork/auto'
require 'muack'
require 'rubyqc'

# enough of NameError: method `old_init' not defined in SortedSet
require 'set'
Set.new

Pork::Executor.__send__(:include, RubyQC::API, Muack::API)

RubyQC.default_parallel = 4

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
    generated.should.kind_of? spec
  else
    generated.should.eq       spec
  end
end
