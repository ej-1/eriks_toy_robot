class Report

  def self.execute(toy_robot)
    if toy_robot.placed_on_board?
      puts [toy_robot.x, toy_robot.y, toy_robot.facing]
    end
  end
end
