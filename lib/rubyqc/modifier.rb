
module RubyQC
  class Modifier
    def initialize args, &block
      @args  = args
      @times = 10
      run(&block)
    end

    def times t, &block
      @times = t
      run(&block)
    end

    def run
      @times.times{
        yield(*@args.map(&:rubyqc))
      } if block_given?
    end
  end
end
