
require 'rubyqc/test'

describe Array do
  describe 'sort' do
    should 'Any front elements should be <= any rear elements' do
      check([Fixnum]*100).times(10) do |array|
        array.sort.each_cons(2).each{ |x, y| x.should <= y }
      end
    end
  end
end

describe Hash do
  describe 'compare_by_identity' do
    should 'Treat diff str with the same contents diff when set' do
      str = 'str'
      forall([true, false], [str, 'str'], [str, 'omg']) do |flag, a, b|
        h = {}
        h.compare_by_identity if flag
        h[a] = h[b] = true

        if (flag && a.object_id != b.object_id) || a != b
          h.size.should.eq 2
        else
          h.size.should.eq 1
        end
      end
    end
  end
end
