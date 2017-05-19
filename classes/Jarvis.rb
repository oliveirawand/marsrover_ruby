require_relative 'Rover'
require_relative 'Plateau'
require_relative 'InOut'

class Jarvis

  attr_reader :rovers
  attr_accessor :plateau
  attr_accessor :inputFileLines
  attr_reader :outputFileLines

  public
  def executeCommands
    if !@inputFileLines || @inputFileLines.length == 0
      puts "No file have been imported."
      return
    end

    @rovers = Array.new
    @outputFileLines = Array.new
    @plateau = Plateau.new(@inputFileLines[0])

    #last rover position inside the rovers array
    lastRoverPosition = nil

    #from the second line to the last
    for i in (1...@inputFileLines.length)

      #if the index is an odd, then it means the line contains the initial rover location
      if i%2 == 1
        roverLocation = @inputFileLines[i].split(' ')
        rover = Rover.new
        rover.x = roverLocation[0].to_i()
        rover.y = roverLocation[1].to_i()
        rover.currentOrientation = roverLocation[2].upcase()

        @rovers << rover

        if lastRoverPosition == nil
          lastRoverPosition = 0
        else
          lastRoverPosition += 1
        end

        #verify if it's the last line of the file
        if i == @inputFileLines.length - 1
          finalPosition = rover.x.to_s() + " "\
          + rover.y.to_s() + " "\
          + rover.currentOrientation

          @outputFileLines << finalPosition
        end

      #otherwise, it's the instructions line
      else
        #separate the instructions inside an array and eliminate the \n at the end
        instructions = @inputFileLines[i].upcase.chomp.split(//)

        for x in (0...instructions.length)
          if instructions[x] == "M"
            if canMoveForward?(@rovers[lastRoverPosition])
              @rovers[lastRoverPosition].move(instructions[x])
            end

          else
            @rovers[lastRoverPosition].move(instructions[x])
          end

        end

        #saves the final position of the rover and adds it to the outputFileLines
        finalPosition = @rovers[lastRoverPosition].x.to_s() + " "\
        + @rovers[lastRoverPosition].y.to_s() + " "\
        + @rovers[lastRoverPosition].currentOrientation
        @outputFileLines << finalPosition

      end
    end
  end

  #the method run can be used to make Jarvis execute all at once
  public
  def run(path)
    io = InOut.new
    @inputFileLines = io.readInput(path)
    executeCommands
    io.writeOutput(path[0, path.length - 4] + "_OUTPUT.txt", @outputFileLines)
  end

  #based on plateau area, determines if a rover can move forward or not
  private
  def canMoveForward?(rover)
    case rover.currentOrientation
    when "N"
      if rover.y < @plateau.maxY
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
      if rover.x < @plateau.maxX
        return true
      end
    end

    return false
  end

end
