
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
    [Array, Integer, Class].each do |klass|
      would klass.name do
        check(klass){ |obj| obj.should.kind_of?(klass) }
      end
    end

    [[], [Integer], [Integer, Array],
     {}, {:a => 0}, {'b' => 1}, {2 => Integer},
     {nil => [Integer]}, {true => {false => [Integer]}}
    ].each do |spec|

      would spec.inspect do
        check(spec) do |generated|
          verify_generated(generated, spec)
        end
      end
    end
  end
end
