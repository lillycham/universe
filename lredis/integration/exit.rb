require 'socket'

def test_exit(server)
  server.puts 'EXIT'
  resp = ''
  while line = server.gets
    resp += line
  end
  puts resp
  raise "exit: failed" unless resp == 'Server shutting down!'
end
