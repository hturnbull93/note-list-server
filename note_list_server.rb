require 'socket'

server = TCPServer.new(2345)

class NoteList
  def initialize(io = Kernel)
    @io = io
    @notes = []
    start
  end

  def start
    # Loop to keep prompting commands
    loop do
      @io.puts '(q)uit, (w)rite, or (r)ead notes?'
      choice = @io.gets.chomp

      case choice
      when 'q'
        quit
        break
      when 'w'
        write
      when 'r'
        read
      else
        unknown_command
      end
    end
  end

  def quit
    @io.puts 'Quitting!'
  end

  def write
    @io.puts 'Write your note:'
    note_body = @io.gets.chomp
    @notes << note_body
  end

  def read
    @io.puts 'Notes:'
    @notes.each_with_index { |note, i| @io.puts "#{i +1}. #{note}" }
  end

  def unknown_command
    @io.puts 'That is not a command.'
  end
end

# Loop to start multiple threads to serve multiple clients
loop do
  Thread.start(server.accept) do |socket|
    NoteList.new(socket)
    socket.close
  end
end
