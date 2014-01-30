
require 'rubyqc/test'

describe RubyQC::API do
  should 'one_of' do
    check([Class]*5) do |klasses|
      check(one_of(*klasses)) do |obj|
        klasses.find{ |klass| obj.kind_of?(klass) }.should.not.nil
      end
    end
  end
end
