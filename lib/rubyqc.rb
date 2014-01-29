
require 'bacon'

module RubyQC
  FixnumMAX = 2 ** (0.size * 8 - 2) - 1
  FixnumMIN = - FixnumMAX - 1

  class Modifier
    def initialize args, &block
      @args = args
      @t = 1
      go(&block)
    end

    def times t, &block
      @t = t
      go(&block)
    end

    def go
      @t.times{
        yield(*@args.map{ |a| gen(a) })
      } if block_given?
    end
  end

  module API
    module_function
    def check *args
      Modifier.new(args)
    end

    def gen a
      if a.kind_of?(Array)
        a.map{ |b| gen(b) }
      elsif a == Fixnum
        rand(FixnumMIN..FixnumMAX)
      end
    end
  end
end

include RubyQC::API

describe Array do
  describe 'sort' do
    should 'Any front elements should be <= any rear elements' do
      check([Fixnum]*100).times(100) do |array|
        array.sort.each_cons(2).each{ |x, y| x.should <= y }
      end
    end
  end
end

Bacon.summary_on_exit
