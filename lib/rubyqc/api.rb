
require 'rubyqc/modifier'

module RubyQC
  module API
    module_function
    def check *args, &block
      RubyQC::Modifier.new(args, &block)
    end

    class SomeOf < Struct.new(:num, :args)
      def rubyqc
        args.sample(num).rubyqc
      end
    end

    class OneOf < SomeOf
      def initialize args
        super(1, args)
      end

      def rubyqc
        super.first
      end
    end

    def someof num, *args
      SomeOf.new(num, args)
    end

    def oneof *args
      OneOf.new(args)
    end
  end
end
