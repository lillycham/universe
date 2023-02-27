require 'socket'

def test_garbage(server)
  server = TCPSocket.open('localhost', 3459)
  server.puts 'kdsakdlavl ;d;afs;dl kdsalldf'
  resp = ''
  while line = server.gets
    resp += line
  end
  puts resp
  raise "Garbage: #{resp} did not match expected response" unless resp == '-unknown cmd'
end
