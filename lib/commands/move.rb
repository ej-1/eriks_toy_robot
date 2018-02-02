class Move
  def self.execute(toy_robot)
    if toy_robot.placed_on_board?
      # instead of facing border use @board.coordinates and see if after move the robot does not match.
      if toy_robot.facing == 'NORTH' # refactor this later so it does not need explicit directions,
                                      # but rather this is instructed somewhere else.
       toy_robot.y += 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.y + 1)
      elsif toy_robot.facing == 'WEST'
        toy_robot.x -= 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.x - 1)
        #toy_robot.x =+ 1 if (toy_robot.x + 1) <= toy_robot.board.x_axis_length
      elsif toy_robot.facing == 'EAST'
        toy_robot.x += 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.x + 1)
      elsif toy_robot.facing == 'SOUTH'
        toy_robot.y -= 1 if (0..toy_robot.board.y_axis_length).include? (toy_robot.y - 1)
      end
    end
  end

  #def self.does_not_move_outside(toy_robot, movement)
    #(toy_robot.y + movement) <= toy_robot.board.y_axis_length && 0 <= (toy_robot.y + movement) &&
    #  (toy_robot.x + movement) <= toy_robot.board.x_axis_length && 0 <= (toy_robot.x + movement)
  #end
end
