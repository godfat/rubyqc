
require 'rubyqc/test'
require 'rubyqc/all'

describe RubyQC::API do
  should 'oneof' do
    check([Class]*5) do |klasses|
      klasses -= [Should] # bacon's Should won't work...
      check(oneof(*klasses)) do |obj|
        begin
          klasses.find{ |klass| obj.kind_of?(klass) }.should.not.nil
        rescue => e
          warn "Cannot find #{obj} in #{klasses}: #{e}"
          raise
        end
      end
    end
  end
end
