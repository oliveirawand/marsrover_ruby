class Plateau

  attr_accessor :maxX
  attr_accessor :maxY

=begin
separete the upper-right coordinates of the first line into X and Y
to define the plateau max area
=end
	def initialize(upperRight)

    coordinates = upperRight.split(' ')
    @maxX = coordinates[0].to_i()
    @maxY = coordinates[1].to_i()

  end

end
