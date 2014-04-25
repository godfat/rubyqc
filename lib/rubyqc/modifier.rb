
module RubyQC
  class Modifier < Struct.new(:args, :cases, :threads)
    def initialize args, &block
      super(args, RubyQC.default_times, RubyQC.default_parallels)
      run(&block)
    end

    def times t, &block
      raise ArgumentError.new(
        "Must run at least once, but got: #{t}") if t <= 0
      self.cases = t
      run(&block)
    end

    def parallels t, &block
      raise ArgumentError.new(
        "Must have at least 1 thread, but got: #{t}") if t <= 0
      self.threads = t
      run(&block)
    end

    private
    def run &block
      if threads == 1
        run_thread(cases, &block)
      else
        ts = threads.times.map{
          Thread.new do
            run_thread(cases / threads, &block)
          end
        } + [Thread.new{ run_thread(cases % threads, &block) }]
        ts.each(&:join)
      end
    end

    def run_thread t
      t.times{
        yield(*args.map(&:rubyqc))
      } if block_given?
    end
  end
end
