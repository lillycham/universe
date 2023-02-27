require 'socket'

def test_echo(server, input)
  server.puts("ECHO " + input)

  response = ''

  while line = server.gets
    response += line
  end

  raise 'echo: failed' unless response == input

  puts "#{response}"
end
