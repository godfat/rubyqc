
require 'rubyqc/test'
require 'rubyqc/all'

describe RubyQC::API do
  would 'oneof' do
    check([Class]*5) do |klasses|
      # klasses -= [Pork::Should] # bacon's Should won't work...
      check(oneof(klasses)) do |obj|
        begin
          klasses.find{ |klass| obj.kind_of?(klass) }.should.not.nil?
        rescue => e
          warn "Cannot find #{obj} in #{klasses}: #{e}"
          raise
        end
      end
    end
  end

  would 'someof' do
    check(2..5, 6..10) do |n, m|
      check([Integer]*m) do |numbers|
        check(someof(n, numbers)) do |nums|
          nums.size.should.eq n
          nums.should.all?{ |nn| numbers.should.include? nn }
        end
      end
    end
  end

  describe 'forall' do
    would 'hard code' do
      times = 0
      forall([1,2], [3,4], [5,6]) do |a, b, c|
        times += 1
        [1,2].should.include? a
        [3,4].should.include? b
        [5,6].should.include? c
      end
      times.should.eq 2**3
    end

    would 'check' do
      check([Integer, Integer],
            [Integer, Integer],
            [Integer, Integer]) do |a, b, c|
        times = 0
        forall(a, b, c) do |aa, bb, cc|
          times += 1
          a.should.include? aa
          b.should.include? bb
          c.should.include? cc
        end
        times.should.eq 2**3
      end
    end

    would 'check check' do
      check(1..5, 1..5) do |n, m|
        check([[Integer]*n.abs]*m.abs) do |a|
          times = 0
          forall(*a) do |*aa|
            times += 1
            a.zip(aa).each{ |(b, bb)| b.should.include? bb }
          end
          times.should.eq n**m
        end
      end
    end
  end
end
