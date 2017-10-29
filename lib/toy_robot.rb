require 'pry'
require_relative 'position_data_validator'

class ToyRobot
  include PositionDataValidator
  attr_accessor :directions, :valid_commands

  def initialize
    @directions = ['north', 'east', 'south', 'west']
    @valid_commands = ['place', 'left', 'right', 'move', 'report']
    handle_input([])
    #place
  end

  private

  def handle_input(position)
    input_array = gets.chomp.split(' ')
    command = input_array.first # => 'MOVE'
    if command.downcase == 'place'
      unless input_array.first == input_array.last # that only place is issues and no postion data
        place(input_array.last)
      end
    end
    # handle if multiple commands of wrong spelling, without killing program.
    if valid_position_data?(position)
      if off_table?(position)
        handle_input(position)
      else
        valid_commands.each do |valid_command|
          if command.downcase == command_string
            send("#{command_string}", position)
          end
        end
      end
    else
      handle_input(position)
    end
  end

  def place(position_data)
    position = position_data.split(',') # => '0,3,west'
    handle_input(position)
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
    handle_input(position)
  end

  def move_unless_at_edge(position, axis, movement)
    hypotethical_move = position[axis].to_i + movement
    unless hypotethical_move > 50 || hypotethical_move < 0
      position[axis] = hypotethical_move
    end
  end

  def left(position)
    handle_input(change_direction(position, -1))
  end

  def right(position)
    handle_input(change_direction(position, 1))
  end

  def change_direction(position, increment) # NEED TO CAHNGE SO THAT NORTH AND EAST ARE TREATED The same
    index = directions.index(position[2])
    position[2] = directions.rotate(increment)[index]
    position
  end

  def report(position)
    print position
    handle_input(position)
  end

  def off_table?(position) # if not on table toy_robot can choose to ignore commands.
    [0,1].map do |axis|
      return true if position[axis].to_i < 0 || 50 < position[axis].to_i
    end.include? true
  end
end

ToyRobot.new
