
require 'rubyqc/test'

describe RubyQC::Modifier do
  should 'parallels' do
    check(5..11, 2..4).parallels(1) do |times, parallels|
      mutex = Mutex.new
      array = []
      mock(Thread).new.times(parallels)

      check.times(times).parallels(parallels) do
        mutex.synchronize{ array << true }
      end

      Muack.verify.should.eq true
      array.size.should.eq times
    end
  end
end
