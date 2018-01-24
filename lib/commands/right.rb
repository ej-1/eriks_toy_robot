require 'facing_instructions.rb'

class Right
  extend FacingInstructions

  def self.execute(toy_robot)
    if toy_robot.placed_on_board?
      toy_robot.facing = facing_instructions[toy_robot.facing]
    end
  end
end
