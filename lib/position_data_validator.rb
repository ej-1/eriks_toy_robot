module PositionDataValidator
  def valid_position_data?(position_array)
    if valid_number_of_arguments?(position_array)
      valid_x_and_y_coordinates?(position_array) && valid_facing?(position_array)
    else
      false
    end
  end

  def valid_number_of_arguments?(position_array)
    position_array.count == 3
  end

  def valid_x_and_y_coordinates?(position_array)
    position_array[0].to_i.is_a?(Integer) && position_array[1].to_i.is_a?(Integer) # check if it can be a interger
  end # check if outside table

  def valid_facing?(position_array)
    ['north', 'east', 'south', 'west'].
      map { |direction| position_array[2] == direction }.include? true
  end
end
