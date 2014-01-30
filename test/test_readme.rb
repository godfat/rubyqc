
require 'rubyqc/test'

describe Array do
  describe 'sort' do
    should 'Any front elements should be <= any rear elements' do
      check([Fixnum]*100).times(100) do |array|
        array.sort.each_cons(2).each{ |x, y| x.should <= y }
      end
    end
  end
end
