
require 'rubyqc/test'

describe 'prelude' do
  should 'lambda' do
    i = 0
    k = 0
    check(lambda{ i += 1 }).parallels(1) do |j|
      k += 1
      i.should.eq j
      i.should.eq k
    end
  end
end
