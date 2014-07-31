
require 'rubyqc/error'

module RubyQC
  class Modifier < Struct.new(:args, :errors, :cases, :threads)
    def initialize args, &block
      super(args, [], RubyQC.default_times, RubyQC.default_parallel)
      run(&block)
    end

    def times t, &block
      raise ArgumentError.new(
        "Must run at least once, but got: #{t}") if t <= 0
      self.cases = t
      run(&block)
    end

    def parallel t, &block
      raise ArgumentError.new(
        "Must have at least 1 thread, but got: #{t}") if t <= 0
      self.threads = t
      run(&block)
    end

    private
    def mutex
      @mutex ||= Mutex.new
    end

    def run &block
      if !block_given?
        # waiting for block to be given
      elsif threads == 1
        run_thread(cases, &block)
      else
        divided = cases / threads
        mod     = cases % threads

        ts = (threads - 1).times.map{
          Thread.new{ run_thread(divided, &block) }
        } + [Thread.new{ run_thread(divided + mod, &block) }]
        ts.each(&:join)

        raise Error.new(cases, errors) unless errors.empty?
      end

      self
    end

    def run_thread t
      t.times do
        if Thread.current == Thread.main
          # we raise errors immediately if we're not running in parallels
          yield(*args.map(&:rubyqc))
        else
          begin
            yield(*args.map(&:rubyqc))
          rescue Exception => e
            mutex.synchronize{ errors << e }
          end
        end
      end
    end
  end
end
