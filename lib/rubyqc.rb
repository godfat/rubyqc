
require 'rubyqc/api'
require 'rubyqc/prelude'

module RubyQC
  singleton_class.module_eval do
    attr_writer :default_times, :default_parallel
    def default_times
      @default_times || 10
    end

    def default_parallel
      @default_parallel || 1
    end
  end
end
