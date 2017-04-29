require_relative 'classes/Jarvis'

=begin
  It's necessary for the file to be inside the "io" folder in project root folder
  so it can be read
=end
puts "Qual o nome do arquivo para importação? "
fileName = gets.chomp

jarvis = Jarvis.new
jarvis.run("io/" + fileName + ".txt")

#jarvis.readInput("io/" + "input" + ".txt")
#jarvis.executeCommands
#puts jarvis.writeOutput("input" + "_OUTPUT.txt")
