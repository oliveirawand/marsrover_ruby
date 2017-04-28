require_relative 'classes/Jarvis'

jarvis = Jarvis.new

puts "Qual o nome do arquivo para importação? "
#fileName = gets.chomp

jarvis.readInput("input" + ".txt")
jarvis.executeCommands
jarvis.writeOutput("input" + "_OUTPUT.txt")


=begin
  It's necessary for the file to be inside the "io" folder in project root folder
  so it can be read
=end
