
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

describe RubyQC do
  should 'sort' do
    check([Fixnum]*100).times(5) do |a|
      a.sort.each_cons(2).each{ |x, y| x.should <= y }
    end
  end

  should 'fixnum' do
    check(Fixnum).times(500) do |n|
      n.should.kind_of Fixnum
    end
  end
end

Bacon.summary_on_exit
