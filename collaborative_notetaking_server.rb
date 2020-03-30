require 'socket'

server = TCPServer.new(2345)

notes = []

# Loop to start multiple threads to serve multiple clients
loop do
  Thread.start(server.accept) do |socket|
    socket.puts 'What is your name?'
    name = socket.gets.chomp
    # Loop to keep prompting commands
    loop do
      socket.puts '(q)uit, (w)rite, or (r)ead notes?'
      choice = socket.gets.chomp

      case choice
      when 'q'
        socket.puts 'Quitting!'
        socket.close
      when 'w'
        socket.puts 'Write your note:'
        note_body = socket.gets.chomp
        notes << "#{name}: #{note_body}"
      when 'r'
        socket.puts 'Notes:'
        notes.each { |note| socket.puts note }
      else
        puts 'That is not a command.'
      end
    end
  end
end
