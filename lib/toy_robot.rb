require 'pry'
require_relative 'position_data_validator'

class ToyRobot
  include PositionDataValidator
  attr_accessor :directions, :valid_commands

  def initialize
    @directions = ['north', 'east', 'south', 'west']
  end

  private

  def place(position_data)
    position = position_data.split(',') # => '0,3,west'
  end

  def move(position)
    {
      'east' => [0, 1],
      'west' => [0, -1],
      'north' => [1, 1],
      'south' => [1, -1],
    }.each do |direction, axis_and_movement|
      axis = axis_and_movement[0]
      movement = axis_and_movement[1]
      if position[2] == direction
        move_unless_at_edge(position, axis, movement)
      end
    end
  end

  def move_unless_at_edge(position, axis, movement)
    hypotethical_move = position[axis].to_i + movement
    unless hypotethical_move > 50 || hypotethical_move < 0
      position[axis] = hypotethical_move
    end
  end

  def left(position)
    change_direction(position, -1)
  end

  def right(position)
    change_direction(position, 1)
  end

  def change_direction(position, increment) # NEED TO CAHNGE SO THAT NORTH AND EAST ARE TREATED The same
    index = directions.index(position[2])
    position[2] = directions.rotate(increment)[index]
    position
  end

  def report(position)
    print position
    position
  end

  def off_table?(position) # if not on table toy_robot can choose to ignore commands.
    [0,1].map do |axis|
      return true if position[axis].to_i < 0 || 50 < position[axis].to_i
    end.include? true
  end
end
