require 'facing_instructions.rb'

class Left
  extend FacingInstructions

  def self.execute(toy_robot)
    toy_robot.facing = facing_instructions.key(toy_robot.facing)
  end
end
