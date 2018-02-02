require_relative 'lib/toy_robot'
require_relative 'lib/command_runner'

@command_runner = CommandRunner.new
#@toy_robot = ToyRobot.new
@board = Board.new(7, 7)

loop do
	include CommandValidator
	command_line_input = gets.chomp
	command, position_data = parse_and_validate_input(command_line_input)
	@command_runner.run_command(command, position_data, @board)
	break if command_line_input == 'exit'
end
