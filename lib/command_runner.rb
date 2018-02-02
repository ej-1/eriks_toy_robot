require_relative 'command_validator'
require_relative 'board.rb'
require_relative 'commands/left.rb'
require_relative 'commands/move.rb'
require_relative 'commands/place.rb'
require_relative 'commands/report.rb'
require_relative 'commands/right.rb'

require 'pry'

class CommandRunner
  include CommandValidator

  def run_command(command, position_data, board)
    if command == 'PLACE'
      position_data[:board] = board
      @toy_robot = Place.execute(position_data)
      #@toy_robot = ToyRobot.new(position_data)  # REFACTOR THIS so its more clear that it is x,y,facing. also find a way to move initialzation fo toyrobot outside of loop.
    elsif @toy_robot.nil?
      puts 'NO TOY ROBOT HAS BEEN PLACED!'
    else
      command_klass = Object.const_get command.capitalize
      @toy_robot.execute(command_klass)
    end
  end
end
