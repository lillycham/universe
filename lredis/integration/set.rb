require 'socket'

def test_set(server, k, v)
  str = "SET #{k} #{v}"
  server.puts str
  resp = ''
  while line = server.gets
    resp += line
  end
  puts resp
  raise 'set: response did not match expected' unless resp == 'OK'
end

server = TCPSocket.open('localhost', 3459)
test_set(server, "a", 10)
