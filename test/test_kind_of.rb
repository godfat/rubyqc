
require 'rubyqc/test'

describe 'kind_of' do
  [Fixnum, Bignum, Array].each do |klass|
    should klass.name do
      check(klass){ |obj| obj.should.kind_of(klass) }
    end
  end

  [[Fixnum], [Fixnum, Array]].each do |array|
    should array.inspect do
      check(array) do |a|
        a.zip(array).each do |(instance, expected)|
          instance.should.kind_of(expected)
        end
      end
    end
  end
end
