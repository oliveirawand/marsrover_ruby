require_relative 'classes/Jarvis'
require_relative 'classes/InOut'

=begin
  It's necessary for the file to be inside the "ioFiles" folder in project root folder
  so it can be read
=end
puts "Qual o nome do arquivo para importação? "
fileName = gets.chomp

jarvis = Jarvis.new
jarvis.run("ioFiles/" + fileName + ".txt")
