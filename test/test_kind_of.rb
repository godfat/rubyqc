
require 'rubyqc/test'

describe 'kind_of' do
  [Fixnum, Bignum, Array].each do |klass|
    should klass.name do
      check(klass){ |obj| obj.should.kind_of(klass) }
    end
  end
end
