
require 'rubyqc/test'

describe RubyQC::API do
  should 'one_of' do
    check([Class]*5) do |klasses|
      klasses -= [Should] # bacon's Should won't work...
      check(one_of(*klasses)) do |obj|
        klasses.find{ |klass| obj.kind_of?(klass) }.should.not.nil
      end
    end
  end
end
