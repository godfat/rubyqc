
require 'rubyqc/test'

describe RubyQC::API do
  should 'one_of' do
    check(Class, Class) do |*klasses|
      check(one_of(*klasses)) do |obj|
        klasses.should.include obj.class
      end
    end
  end
end
