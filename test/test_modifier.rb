
require 'rubyqc/test'

describe RubyQC::Modifier do
  should 'times' do
    check(2..10) do |times|
      t = 0
      check.times(times){ t += 1 }
      t.should.eq times
    end
  end

  describe 'parallels' do
    should 'have correct times' do
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

    should 'raise error immediately if not running in parallels' do
      begin
        t = -1
        check.times(10).parallels(1) do
          t += 1
          raise 'boom'
        end
      rescue => e
        t      .should.eq 0
        e.class.should.eq RuntimeError
      end
    end

    should 'capture errors and report if we are running in parallels' do
      check(4..8) do |parallels|
        check(1..parallels) do |errors|
          t = -1
          m = Mutex.new
          begin
            check.times(10).parallels(parallels) do
              m.synchronize do
                t += 1
                raise t.to_s if t < errors
              end
            end
          rescue RubyQC::Error => e
            e.times      .should.eq RubyQC.default_times
            e.errors.size.should.eq errors
            e.errors.map(&:message).sort.each.with_index do |msg, index|
              msg.should.eq index.to_s
            end
          end
        end
      end
    end
  end
end
