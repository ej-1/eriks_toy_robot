require 'spec_helper'
require 'commands/left.rb'
require 'toy_robot.rb'
require 'board.rb'
require 'pry'

RSpec.describe Left, '#runs Left command' do

  context 'ToyRobot placed on table' do

	  before do
	  	@board = Board.new(4, 4)
	    @toy_robot = ToyRobot.new({:x=>0, :y=>3, :facing=>'EAST', :board=>@board})
	  end

    it 'turns faces EAST' do
    	@toy_robot.facing = 'EAST'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('NORTH')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(3)
    end

    it 'turns faces WEST' do
    	@toy_robot.facing = 'WEST'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('SOUTH')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(3)
    end

     it 'turns faces SOUTH' do
     	@toy_robot.facing = 'SOUTH'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('EAST')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(3)
    end

    it 'turns faces NORTH' do
    	@toy_robot.facing = 'NORTH'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('WEST')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(3)
    end
  end

  context 'ToyRobot not placed on table' do

	  before do
	  	@board = Board.new(4, 4)
	    @toy_robot = ToyRobot.new({:x=>0, :y=>5, :facing=>'EAST', :board=>@board})
	  end

    it 'turns faces EAST and ignores Left command' do
     	@toy_robot.facing = 'EAST'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('EAST')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(5)
    end

    it 'turns faces WEST and ignores Left command' do
    	@toy_robot.facing = 'WEST'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('WEST')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(5)
    end

     it 'turns faces SOUTH and ignores Left command' do
     	@toy_robot.facing = 'SOUTH'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('SOUTH')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(5)
    end

    it 'turns faces NORTH and ignores Left command' do
    	@toy_robot.facing = 'NORTH'
      Left.execute(@toy_robot)
      expect(@toy_robot.facing).to eq('NORTH')
      expect(@toy_robot.x).to eq(0)
      expect(@toy_robot.y).to eq(5)
    end
  end
end
