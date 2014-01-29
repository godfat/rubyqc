
require 'rubyqc/kernel'
require 'rubyqc/modifier'

module RubyQC
  module API
    module_function
    def check *args
      RubyQC::Modifier.new(args)
    end
  end
end
