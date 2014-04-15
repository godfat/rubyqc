
require 'socket'

class Addrinfo
  def self.rubyqc
    Socket.ip_address_list.sample
  end
end if Object.const_defined?(:Addrinfo) # rubinius does not have this class

class Socket
  def self.rubyqc
    for_fd(BasicSocket.rubyqc.fileno)
  end
end

class BasicSocket
  def self.rubyqc
    [UNIXSocket, IPSocket].sample.rubyqc
  end
end

class IPSocket
  def self.rubyqc
    [TCPSocket, UDPSocket].sample.rubyqc
  end
end

class UNIXServer
  def self.rubyqc
    require 'tempfile'
    tmp  = Tempfile.new('sock')
    path = tmp.path
    tmp.close!
    new(path)
  end
end

class UNIXSocket
  def self.rubyqc
    new(UNIXServer.rubyqc.path)
  end
end

class TCPServer
  def self.rubyqc
    new(0)
  end
end

class TCPSocket
  def self.rubyqc
    new(*TCPServer.rubyqc.addr[1..2].reverse)
  end
end

class UDPSocket
  def self.rubyqc
    new
  end
end
