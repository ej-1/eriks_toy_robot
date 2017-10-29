require_relative 'lib/toy_robot'
require_relative 'lib/position_data_validator'

require 'pry'

module CommandValidator
	include PositionDataValidator

	def parse_and_validate_input(input)
		
		input_array = input.split(' ')
		command = input_array.first.downcase
		position_data = input_array.last.downcase.split(',')

		if is_place_command?(command) && valid_position_data?(position_data)
			return command, position_data
		else
			return valid_command?(command)
		end
	end

	def valid_command?(command)
		valid_commands = ['place', 'left', 'right', 'move', 'report']
		valid_commands.each do |valid_command|
			if command == valid_command
				return command
			else
				puts 'invalid command'
				return nil
			end
		end
	end

	def is_place_command?(command)
		command == 'place'
	end
end


class CommandRunner
	include CommandValidator

	def run_command(command_line_input, toy_robot)
		command, position_data = parse_and_validate_input(command_line_input)
		#toy_robot.send(command, position_data)
	end
end


@command_runner = CommandRunner.new
@toy_robot = ToyRobot.new
loop do
	command_line_input = gets.chomp
	@command_runner.run_command(command_line_input, @toy_robot)
	binding.pry
	#break if command_line_input == 'exit'
end
