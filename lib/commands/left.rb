require './lib/facing_instructions.rb'

class Left
  extend FacingInstructions

  def self.execute(toy_robot)
    if toy_robot.placed_on_board?
      toy_robot.facing = facing_instructions.key(toy_robot.facing)
    end
  end
end
