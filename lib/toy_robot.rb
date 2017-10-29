require 'pry'
require_relative 'position_data_validator'

class ToyRobot
  include PositionDataValidator

  attr_accessor :position_and_facing

  def send_method(command, position_data)
    if command
      if valid_place_command_has_been_issued? && on_table?
        send(command)
      else
        send(command, position_data)
      end
    end
  end

  private

  def valid_place_command_has_been_issued?
    !position_and_facing.nil?
  end

  def place(position_data) #=> {x: 0, y: 1, facing: west}
    @position_and_facing = 
    {
      x: position_data[0].to_i,
      y: position_data[1].to_i,
      facing: position_data[2].downcase
    }
  end

  def right
    change_direction({
      'north' => 'east',
      'east' => 'east',
      'south' => 'east',
      'west' => 'north',
    })
  end

  def left
    change_direction({
      'north' => 'west',
      'east' => 'north',
      'south' => 'west',
      'west' => 'west',
    })
  end

  def change_direction(directions_hash)
    new_direction = directions_hash[position_and_facing[:facing]]
    position_and_facing[:facing] = new_direction
  end

  def report
    print position_and_facing.values
  end

  #   x:0,y:5         x:5,y:5
  #    +----------------+
  #    |                |
  #    |                |
  #    |                |
  #    |                |
  #    |                |
  #    |                |
  #    +----------------+
  #   x:0,y:0        x:5,y:0

  def movement_instructions
    {
      #'facing' => how to change current x and y coordinates.
      'east'  =>  {x: 1,  y: 0},
      'west'  =>  {x: -1, y: 0},
      'north' =>  {x: 0,  y: 1},
      'south' =>  {x: 0,  y: -1}
    }
  end

  def move
    facing = position_and_facing[:facing]
    movement = movement_instructions[facing]
    unless at_edge_facing_outward?(facing)
      position_and_facing[:x] += movement[:x]
      position_and_facing[:y] += movement[:y]
    end
  end

  def at_edge_facing_outward?(direction)
    facing_coordinate = {
      'east'  =>  {x: 5},
      'west'  =>  {x: 0},
      'north' =>  {y: 5},
      'south' =>  {y: 0}
    }[direction]
    border_axis = facing_coordinate.keys.join('').to_sym
    border_coordinate = facing_coordinate.values.join('').to_i
    current_coordinate = position_and_facing[border_axis]
    current_coordinate == border_coordinate
  end

  def on_table?
    unless position_and_facing.nil?
      position_and_facing[:x].between?(0, 5) && position_and_facing[:x].between?(0, 5)
    end
  end
end
