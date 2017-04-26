class Plateau

  attr_accessor :maxX
  attr_accessor :maxY

=begin
separete the upper-right coordinates of the first line into X and Y
to define the plateau max area
=end
	def setPlateauArea(upperRight)

    coordinates = upperRight.split(' ')
    @maxX = coordinates[0]
    @maxY = coordinates[1]

  end
