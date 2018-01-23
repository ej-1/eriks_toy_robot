require_relative 'command_validator'
require_relative 'poodr'
require 'pry'


class CommandRunner
  include CommandValidator

  def run_command(command, position_data, board)
    if command == 'PLACE'
      position_data[:board] = board
      @toy_robot = Place.execute(position_data)
      #@toy_robot = ToyRobot.new(position_data)  # REFACTOR THIS so its more clear that it is x,y,facing. also find a way to move initialzation fo toyrobot outside of loop.
    else
      command_klass = Object.const_get command.capitalize
      @toy_robot.execute(command_klass)
    end
  end
end
