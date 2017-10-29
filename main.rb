require_relative 'lib/toy_robot'
require_relative 'lib/command_runner'

require 'pry'


@command_runner = CommandRunner.new
@toy_robot = ToyRobot.new

loop do
	command_line_input = gets.chomp
	@command_runner.run_command(command_line_input, @toy_robot)
	#break if command_line_input == 'exit'
end
