require_relative 'position_data_validator'

module CommandValidator
  VALID_COMMANDS = ['PLACE', 'LEFT', 'RIGHT', 'MOVE', 'REPORT']

  include PositionDataValidator

  def parse_and_validate_input(input)
    # What the method should do:
    # separate into array.
    # Check command.
    # if the command is valid, check that the rest of the input conforms to position format standard.
    # if it conforms send command and position data
    # else if only command, send only command.

    input_array = input.split(' ')

    command         = input_array.first
    remaining_input = input_array.pop
    
    if valid_command?(command)
      position_data = remaining_input.split(',')
      if is_place_command?(command) && valid_position_data?(position_data)
        position_hash = { x: position_data.first.to_i,
                          y: position_data[1].to_i, # add check for valid position data before this to avoid .to_i blowing up before.
                          facing: (position_data.last.upcase if position_data.last.upcase) }
        return [command.upcase, position_hash]
      else
        [command.upcase, nil]
      end
    end
  end

  private

  def is_place_command?(command)
    command == 'PLACE'
  end

  def valid_command?(command)
    VALID_COMMANDS.find { |valid_command| command.upcase == valid_command }
  end
end
