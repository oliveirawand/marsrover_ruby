class InOut

  @validRoverOrientations
  @validRoverInstructions

  def initialize
    @validRoverOrientations = ["N", "S", "W", "E"]
    @validRoverInstructions = ["M", "R", "L"]
  end

  public
  def readInput(path)
    inputFileLines = Array.new

    #verify if the file exists
    if File.file?(path)
      File.open(path, "r:UTF-8").each do |line|
        if line != nil
          inputFileLines << line.chomp
        end
      end

      #checks if the files is empty
      if !inputFileLines || inputFileLines.length == 0
        puts "\nThe File is empty."
        exit

      #validates the imported file
      elsif !isAValidFileInput?(inputFileLines)
        printExample()
        exit

      end

    else
      puts "The mencioned input file doesn't exist!\nPlease, check it out."
      exit
    end

    return inputFileLines
  end

  #writes the output file and puts it on the screen
  public
  def writeOutput(path, outputFileLines)
     if !outputFileLines || outputFileLines.length == 0
       "Nothing to export."
       return
     end

     puts "\nFinal rovers position(s):"
     rover = 0

     outputFile = File.open(path, "w")
     for line in outputFileLines
       outputFile << line + "\n"
       puts "------Rover " + (rover += 1).to_s() + "------"
       puts line + "\n"
     end
     outputFile.close
   end

  #this method has all the rules for a valid file to be inputted
  private
  def isAValidFileInput?(inputFileLines)
    if inputFileLines.length < 2
      return false
    end

    for l in (0...inputFileLines.length)
      plateau = inputFileLines[0].split(" ")

      #checks if is the first line
      if l == 0
          #checks the amount of elements
          if plateau.size != 2
            puts "Invalid line: " + (l + 1).to_s() + " - Invalid plateau size."
            return false
          end

          #checks if all elements are numeric
          begin
            Integer(plateau[0])
            Integer(plateau[1])
          rescue
            puts "Invalid line: " + (l + 1).to_s() + " - Plateau coordinates are not numbers."
            return false
          end

      #checks if is a rover's initial position line
      elsif l%2 == 1
        initialPosition = inputFileLines[l].split(" ")

        if initialPosition.length != 3
          puts "Invalid line: " + (l + 1).to_s() + " - The line has more or less"\
           + " than 3 elements that must be separated by blank spaces."
          return false

          #checks if Rover's initial position is out of the plateau
        elsif initialPosition[0] > plateau[0] or initialPosition[1] > plateau[1]
          puts "Rover's initial position at line " + (l + 1).to_s() + " is out of Plateau's range."
          return false

        elsif !@validRoverOrientations.include? initialPosition[2]
          puts "Invalid line: " + (l + 1).to_s() + " - The rovers orientation is invalid."
          return false

        else
          begin
            Integer(initialPosition[0])
            Integer(initialPosition[1])
          rescue
            puts "Invalid line: " + (l + 1).to_s() + " - The first two elements of the line are not valid numbers!"
            return false
          end
        end

      else
        instructions = inputFileLines[l].chomp.split(//)
        for i in instructions
          if !@validRoverInstructions.include? i.upcase()
            puts "Invalid line: " + (l + 1).to_s() + " - There must be only valid letters for rover instructions."
            return false
          end
        end
      end
    end
    return true;
  end

  private
  def printExample
    puts "\nInvalid file! Please, use an input with at least two lines following the example below:"
    puts "\n5 5"
    puts "1 2 N"
    puts "MMMLRMRLMRL"
    puts "3 5 S"
    puts "LRRRMRLMRLMMM"
  end

end
