require 'spec_helper'
require 'rails_helper'
require 'toy_robot.rb'
require 'board.rb'


RSpec.describe ToyRobot, 'ToyRobot' do

  describe 'ToyRobot' do

    before do
      @board = Board.new(4, 4)
    end

    context 'receives valid args' do
      it 'creates toy_robot' do
        @toy_robot = ToyRobot.new({:x=>4, :y=>0, :facing=>"EAST", :board=>@board})
        expect(@toy_robot.x).to eq(4)
        expect(@toy_robot.y).to eq(0)
        expect(@toy_robot.facing).to eq('EAST')
      end

      it 'confirms that is placed on board' do
        @toy_robot = ToyRobot.new({:x=>4, :y=>0, :facing=>"EAST", :board=>@board})
        expect(@toy_robot.placed_on_board?).to eq(true)
      end

      it 'confirms that is not placed on board' do
        @toy_robot = ToyRobot.new({:x=>4, :y=>5, :facing=>"EAST", :board=>@board})
        expect(@toy_robot.placed_on_board?).to eq(false)
      end
    end

    context 'receivesin valid args' do
      it 'creates toy_robot anyways' do
        @toy_robot = ToyRobot.new({:x=>'A', :y=>false, :facing=>99, :board=>@board})
        expect(@toy_robot.x).to eq('A')
        expect(@toy_robot.y).to eq(false)
        expect(@toy_robot.facing).to eq(99)
      end

      it 'confirms that is placed on board' do
        @toy_robot = ToyRobot.new({:x=>'A', :y=>false, :facing=>99, :board=>@board})
        expect(@toy_robot.placed_on_board?).to eq(false)
      end

      it 'confirms that is not placed on board' do
        @toy_robot = ToyRobot.new({:x=>'A', :y=>false, :facing=>99, :board=>@board})
        expect(@toy_robot.placed_on_board?).to eq(false)
      end
    end

  end
end
