
require 'rubyqc/prelude'
require 'rubyqc/modifier'

module RubyQC
  module API
    module_function
    def check *args, &block
      RubyQC::Modifier.new(args, &block)
    end

    def one_of *args
      args.sample
    end
  end
end
