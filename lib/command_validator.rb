require_relative 'position_data_validator'

module CommandValidator
	include PositionDataValidator

	def valid_commands
		['place', 'left', 'right', 'move', 'report']
	end

	def parse_and_validate_input(input)
		command, position_data = parse_input(input)
		if is_place_command?(command) && valid_position_data?(position_data) # TOY_ROBOT SHOULD CHECK IF PLLACE COMMAND
			return command, position_data
		else
			return valid_command?(command)
		end
	end

	def parse_input(input)
		input_array = input.split(' ')
		command = input_array.first.downcase
		position_data = input_array.last.downcase.split(',')
		[command, position_data]
	end

	def is_place_command?(command)
		command == 'place'
	end

	def valid_command?(command)
		valid_commands.each do |valid_command|
			if command == valid_command
				return command
			end
		end
		nil
	end
end
