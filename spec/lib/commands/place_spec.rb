require 'spec_helper'
require 'commands/place.rb'
require 'toy_robot.rb'
require 'board.rb'
require 'pry'

RSpec.describe Place, '#runs Place command' do

  it 'Receives valid args' do
    board = Board.new(4, 4)
    args = {:x=>0, :y=>3, :facing=>'EAST', :board=>board}
    @toy_robot = Place.execute(args)
    expect(@toy_robot.facing).to eq('EAST')
    expect(@toy_robot.x).to eq(0)
    expect(@toy_robot.y).to eq(3)
  end

  # Should I test for invalid args. Right now x, y and facing
  # can be anything that is passed to ToyRobot class. Except board
  # there at least needs to be a object tht responds to .coordinates method.
  # Where should I enforce what args are sent. In ToyRobot class or before?
  # Maybe use Contracts?
end
