
require 'rubyqc/test'

describe Array do
  describe 'sort' do
    would 'Any front elements should be <= any rear elements' do
      check([Fixnum]*100).times(10) do |array|
        array.sort.each_cons(2).each{ |x, y| x.should <= y }
      end
    end
  end
end

describe Hash do
  describe 'compare_by_identity' do
    would 'Treat diff arr with the same contents diff when set' do
      arr = [0]
      forall(booleans, [arr, [0]], [arr, [1]]) do |flag, a, b|
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

class User < Struct.new(:id, :name)
  def self.rubyqc
    new(Fixnum.rubyqc, String.rubyqc)
  end
end

describe 'User.rubyqc' do
  would 'Generate random users' do
    check(User) do |user|
      user     .should.kind_of? User
      user.id  .should.kind_of? Fixnum
      user.name.should.kind_of? String
    end
  end
end
