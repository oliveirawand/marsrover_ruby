require_relative 'classes/Jarvis'
require_relative 'classes/Plateau'
require 'test/unit'

class TestClass < Test::Unit::TestCase

  def test_readInput
    puts "Test about the import of lines from file to be processed."

    path = "io/inputTest.txt"
    inputFileLines = Array.new
    jarvis = Jarvis.new

    inputFileLines << "5 5"
    inputFileLines << "1 2 N"
    inputFileLines << "LMLMLMLMM"
    inputFileLines << "3 3 E"
    inputFileLines << "MMRMMRMRRM"

    #read file by Jarvis
    jarvis.readInput(path)

    #compare imported lines in by Jarvis and Test
    assert_equal(inputFileLines, jarvis.inputFileLines, "Inputted lines from file aren't the same!!!")
  end

  def test_executeCommands
    #scenario
    inputFileLines = ["7 9", "0 0 E", "MMMMMMMMMMMMMMMMMMMMMMMMM", "0 0 N", "MMMMMMMMMMMMMMMMMMMM", "2 5 S"]
    outputFileLines = Array.new
    rovers = Array.new

    #last rover position inside the rovers array
    lastRoverPosition = nil

    #from the second line to the last
    for i in (1...inputFileLines.length)
      #if a index is an odd, then it means the line contains the initial rover location
      if i%2 == 1
        roverLocation = inputFileLines[i].split(' ')
        rover = Rover.new
        rover.x = roverLocation[0].to_i()
        rover.y = roverLocation[1].to_i()
        rover.currentOrientation = roverLocation[2].upcase()

        rovers << rover

        if lastRoverPosition == nil
          lastRoverPosition = 0
        else
          lastRoverPosition += 1
        end

        #verify if it's the last line of the file
        if i == inputFileLines.length - 1
          finalPosition = rover.x.to_s() + " "\
          + rover.y.to_s() + " "\
          + rover.currentOrientation

          outputFileLines << finalPosition
        end

      #otherwise, it's the instructions line
      else
        #separate the instructions inside an array eliminate the \n at the end
        instructions = inputFileLines[i].upcase.chomp.split(//)

        for x in (0...instructions.length)
          if instructions[x] == "M"
            if canMoveForward?(rovers[lastRoverPosition])
              rovers[lastRoverPosition].move(instructions[x])
            end
          else
            rovers[lastRoverPosition].move(instructions[x])
          end
        end

        finalPosition = rovers[lastRoverPosition].x.to_s() + " "\
        + rovers[lastRoverPosition].y.to_s() + " "\
        + rovers[lastRoverPosition].currentOrientation

        outputFileLines << finalPosition

      end
    end

    plateau = Plateau.new(inputFileLines[0])
    jarvis = Jarvis.new
    jarvis.inputFileLines = inputFileLines
    jarvis.plateau = plateau
    jarvis.executeCommands

    #verify if the the final rovers positions are the same
    assert_equal(outputFileLines, jarvis.outputFileLines, "Output DOESN'T match!")

  end

  def canMoveForward?(rover)
    plateau = Plateau.new("7 9")
    case rover.currentOrientation
    when "N"
      if rover.y < plateau.maxY
        return true
      end

    when "S"
      if rover.y > 0
        return true
      end

    when "W"
      if rover.x > 0
        return true
      end

    when "E"
      if rover.x < plateau.maxX
        return true
      end
    end

    return false
  end

end
