require_relative 'command_validator'

class CommandRunner
	include CommandValidator

	def run_command(command_line_input, toy_robot)
		command, position_data = parse_and_validate_input(command_line_input)
		#toy_robot.send(command, position_data)
	end
end
