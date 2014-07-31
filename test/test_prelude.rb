
require 'rubyqc/test'

describe 'prelude' do
  would 'lambda' do
    i = 0
    k = 0
    check(lambda{ i += 1 }).parallel(1) do |j|
      k += 1
      i.should.eq j
      i.should.eq k
    end
  end

  describe 'kind_of' do
    [Fixnum, Bignum, Array, Integer, Class].each do |klass|
      would klass.name do
        check(klass){ |obj| obj.should.kind_of?(klass) }
      end
    end

    [[], [Fixnum], [Fixnum, Array],
     {}, {:a => 0}, {'b' => 1}, {2 => Integer},
     {nil => [Fixnum]}, {true => {false => [Bignum]}}
    ].each do |spec|

      would spec.inspect do
        check(spec) do |generated|
          verify_generated(generated, spec)
        end
      end
    end
  end
end
