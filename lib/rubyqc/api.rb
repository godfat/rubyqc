
require 'rubyqc/modifier'

module RubyQC
  module API
    module_function
    def check *args, &block
      RubyQC::Modifier.new(args, &block)
    end

    class OneOf < Struct.new(:args)
      def rubyqc
        args.sample.rubyqc
      end
    end

    def one_of *args
      OneOf.new(args)
    end
  end
end
