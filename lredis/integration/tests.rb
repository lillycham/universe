require 'socket'
require_relative 'exit'
require_relative 'garbage'
require_relative 'echos'
require_relative 'set'

begin
  server = TCPSocket.open('localhost', 3459)
  test_echo(server, 'hello, world')
  test_garbage(server)  
  test_exit(server)
  test_set(server, 'a', 10)
rescue => e
  puts "Test failed: #{e.message}"
ensure
  server.close
end
