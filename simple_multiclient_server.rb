require 'socket'

server = TCPServer.new(2345)

# Loop to start multiple threads to serve multiple clients
loop do
  Thread.start(server.accept) do |socket|
    # Loop to keep getting things to repeat
    loop do
      socket.puts "What do you say?"
      they_said = socket.gets.chomp
      if they_said == 'quit'
        socket.puts 'Quitting'
        socket.close
      else
        socket.puts "You said: #{they_said}!"
      end
    end
  end
end
