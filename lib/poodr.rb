class Board
  attr_reader :x_axis_length, :y_axis_length

  def initialize(x, y)
    @x_axis_length = x
    @y_axis_length = y
  end

  def coordinates
    (0..x_axis_length).map { |x| (0..y_axis_length).map { |y| {x: x, y: y} } }.flatten
  end

end


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



module FacingInstructions

  def facing_instructions
    {
      'NORTH' => 'EAST',
      'EAST' => 'SOUTH',
      'SOUTH' => 'WEST',
      'WEST' => 'NORTH',
    }
  end
end


class Place
  include FacingInstructions

  def self.execute(args)
    toy_robot = ToyRobot.new(args)
  end

end


class Move
  def self.execute(toy_robot)
    if toy_robot.placed_on_board?
      # instead of facing border use @board.coordinates and see if after move the robot does not match.
      if toy_robot.facing == 'NORTH' # refactor this later so it does not need explicit directions,
                                      # but rather this is instructed somewhere else.
       toy_robot.y += 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.y + 1)
      elsif toy_robot.facing == 'WEST'
        toy_robot.x -= 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.x - 1)
        #toy_robot.x =+ 1 if (toy_robot.x + 1) <= toy_robot.board.x_axis_length
      elsif toy_robot.facing == 'EAST'
        toy_robot.x += 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.x + 1)
      elsif toy_robot.facing == 'SOUTH'
        toy_robot.y -= 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.y - 1)
      end
    end
  end

  #def self.does_not_move_outside(toy_robot, movement)
    #(toy_robot.y + movement) <= toy_robot.board.y_axis_length && 0 <= (toy_robot.y + movement) &&
    #  (toy_robot.x + movement) <= toy_robot.board.x_axis_length && 0 <= (toy_robot.x + movement)
  #end
end


class Right
  extend FacingInstructions

  def self.execute(toy_robot)
    toy_robot.facing = facing_instructions[toy_robot.facing]
  end

end

class Left
  extend FacingInstructions

  def self.execute(toy_robot)
    toy_robot.facing = facing_instructions.key(toy_robot.facing)
  end

end


class Report

  def self.execute(toy_robot)
    puts [toy_robot.x, toy_robot.y, toy_robot.facing]
  end
end


