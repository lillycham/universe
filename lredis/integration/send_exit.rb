require 'socket'
require_relative 'exit'
serv = TCPSocket.open('localhost', 3459)
test_exit(serv)
