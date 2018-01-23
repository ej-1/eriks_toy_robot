module PositionDataValidator
  DIRECTIONS = ['NORTH', 'WEST', 'EAST', 'SOUTH']

  def valid_position_data?(position_array)
    binding.pry
    valid_number_of_arguments?(position_array) &&
      valid_x_and_y_coordinates?(position_array) &&
      valid_facing?(position_array)
  end

  def valid_number_of_arguments?(position_array)
    position_array.count == 3
  end

  def valid_x_and_y_coordinates?(position_array)
    position_array.first.to_i.is_a?(Integer) && position_array[1].to_i.is_a?(Integer) # check if it can be a interger
  end # check if outside table

  def valid_facing?(position_array)
    DIRECTIONS.
      map { |direction| position_array.last == direction }.include? true
  end
end
