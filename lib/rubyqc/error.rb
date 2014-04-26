
module RubyQC
  class Error < RuntimeError
    attr_reader :times, :errors
    def initialize times, errors
      @times, @errors = times, errors
      super("RubyQC::Error: #{errors.size} errors out of #{times}:" \
            " #{errors.inspect}")
    end
  end
end
