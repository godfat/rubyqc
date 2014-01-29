
module RubyQC
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

    private
    def go
      @t.times{
        yield(*@args.map{ |a| a.rubyqc })
      } if block_given?
    end
  end
end
