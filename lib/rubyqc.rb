
require 'rubyqc/kernel'
require 'rubyqc/modifier'

module RubyQC
  module API
    module_function
    def check *args, &block
      RubyQC::Modifier.new(args, &block)
    end
  end
end
