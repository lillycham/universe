require 'socket'

msg = ARGV.reject(&:empty?).join(' ').prepend('ECHO ')
server = TCPSocket.open('localhost', 3459)
server.puts msg
response = '' 
while line = server.gets
  response += line
end

puts "< #{response}"
server.close
server.close
