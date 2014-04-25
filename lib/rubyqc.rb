
require 'rubyqc/api'
require 'rubyqc/prelude'

module RubyQC
  singleton_class.module_eval do
    attr_writer :default_times, :default_parallels
    def default_times
      @default_times || 10
    end

    def default_parallels
      @default_parallels || 1
    end
  end
end
