# Starting out the robot only needs to know about itself.
# It just needs to know it's position on the board
# and which way it is facing.
# It could be argued that the robot must know about the board to know its position
# alternatively the board hold the position info about the robot.

# Toyrobot should not be able to receive other than integers for x, y
# and not unvalid facings.
class ToyRobot
  attr_reader :board
  attr_accessor :x, :y, :facing

  def initialize(args)
    @x          = args[:x]
    @y          = args[:y]
    @facing     = args[:facing]
    @board      = args[:board] # find a way to perhaps extract board later.
  end

  # Here it needs to know about board, might be ok,
  # since ToyRobot does not start out needing to know about board.
  def placed_on_board?
    toy_robot_position = {x: self.x, y: self.y}
    board.coordinates.include? toy_robot_position
  end

  def execute(command)
    command.execute(self) # page 93 in POODR. Now the toy_robot executes commands,
                          # instead of command executing robot.
  end
end
