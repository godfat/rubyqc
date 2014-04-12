
require 'delegate'

class Delegator
  def self.rubyqc
    SimpleDelegator.rubyqc
  end
end

class SimpleDelegator
  def self.rubyqc
    new(Class.rubyqc.rubyqc)
  end
end
