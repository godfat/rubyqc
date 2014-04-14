
require 'weakref'

# In MRI, WeakRef is a Delegator, so this is not really needed.
# But in Rubinius, WeakRef is not a Delegator, therefore we need
# to provide the exact same implementation here.
class WeakRef
  def self.rubyqc
    new(Class.rubyqc.rubyqc)
  end
end
