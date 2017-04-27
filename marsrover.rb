require_relative 'classes/Jarvis'

jarvis = Jarvis.new

puts "Qual o nome do arquivo para importação? "
#fileName = gets.chomp

jarvis.readInput("input" + ".txt")
jarvis.executeCommands
jarvis.writeOutput("input" + "_OUTPUT.txt")
