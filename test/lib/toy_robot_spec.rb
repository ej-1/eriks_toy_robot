require 'spec_helper'
require 'rails_helper'
require 'toy_robot.rb'
require 'pry'


RSpec.describe ToyRobot, '#runs ToyRobot' do

  before do
    #toy_robot = ToyRobot.new
    #allow($stdin).to receive('0, 0, east')
    #toy_robot.stub!(:gets) { "0, 0, east\n" }
    ToyRobot.new
    $stdin = StringIO.new("James T. Kirk\n")
    binding.pry
  end

  context 'sends wrong commands' do
    it 'receives bullocks commands' do
      # send bla, bla bla
    end

    it 'rotates 90 degrees clockwise to the RIGHT' do
    end

    it 'rotates 90 degrees counter clockwise to the LEFT' do
    end

    it 'REPORTS position' do
    end
  end

  context 'sends wrong commands' do
    it 'receives bullocks commands' do
      # send bla, bla bla
    end

	  it 'place toyrobot' do

	  end

	  it 'discards all commands until a valid place command is issued' do

	  end
  end

  context 'robot is at the border facing outward' do
    it 'do not move the robot forward' do

    end
  end

  context 'robot is not facing the edge of the board' do
    it 'move the robot one unit forward successfully' do
      [1..49].each do |x_position|
        "#{x_position}, 0, west"
      end
    end
  end

end

