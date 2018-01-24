require 'spec_helper'
require 'commands/move.rb'
require 'toy_robot.rb'
require 'board.rb'
require 'pry'

RSpec.describe Move, '#runs Move command' do

  describe 'run Move command' do

    before do
      @board = Board.new(4, 4)
    end

	  context 'toy_robot not placed on table' do
	    it 'ignores Place command' do
	      @toy_robot = ToyRobot.new({:x=>0, :y=>5, :facing=>'EAST', :board=>@board})
	      STDOUT.should_receive(:puts).exactly(0).times
	      Move.execute(@toy_robot)
	    end
	  end

    context 'positioned on table, at border facing EAST' do
      [
        {:x=>4, :y=>0, :facing=>"EAST"},
        {:x=>4, :y=>5, :facing=>"EAST"},
        {:x=>4, :y=>2, :facing=>"EAST"}
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(position_data[:y])
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end

    context 'positioned on table, NOT at border facing EAST' do
      [
        {:x=>3, :y=>0, :facing=>"EAST"},
        {:x=>3, :y=>4, :facing=>"EAST"},
        {:x=>3, :y=>2, :facing=>"EAST"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(4)
          expect(@toy_robot.y).to eq(position_data[:y])
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end

    context 'positioned on table, at border facing WEST' do
      [
        {:x=>0, :y=>0, :facing=>"WEST"},
        {:x=>0, :y=>4, :facing=>"WEST"},
        {:x=>0, :y=>2, :facing=>"WEST"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(position_data[:y])
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end

    context 'positioned on table, NOT at border, facing WEST' do
      [
        {:x=>2, :y=>0, :facing=>"WEST"},
        {:x=>2, :y=>4, :facing=>"WEST"},
        {:x=>2, :y=>2, :facing=>"WEST"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(1)
          expect(@toy_robot.y).to eq(position_data[:y])
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end


    context 'positioned on table, at border facing NORTH' do
      [
        {:x=>0, :y=>4, :facing=>"NORTH"},
        {:x=>4, :y=>4, :facing=>"NORTH"},
        {:x=>2, :y=>4, :facing=>"NORTH"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(position_data[:y])
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end

    context 'positioned on table, NOT at border, facing NORTH' do
      [
        {:x=>0, :y=>2, :facing=>"NORTH"},
        {:x=>4, :y=>2, :facing=>"NORTH"},
        {:x=>2, :y=>2, :facing=>"NORTH"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(3)
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end


    context 'positioned on table, at border facing SOUTH' do
      [
        {:x=>0, :y=>0, :facing=>"SOUTH"},
        {:x=>4, :y=>0, :facing=>"SOUTH"},
        {:x=>2, :y=>0, :facing=>"SOUTH"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(position_data[:y])
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end

    context 'positioned on table, NOT at border, facing SOUTH' do
      [
        {:x=>0, :y=>2, :facing=>"SOUTH"},
        {:x=>4, :y=>2, :facing=>"SOUTH"},
        {:x=>2, :y=>2, :facing=>"SOUTH"},
      ].each do |position_data|
        it 'receives MOVE command' do
        	position_data[:board] = @board
        	@toy_robot = ToyRobot.new(position_data)
        	Move.execute(@toy_robot)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(1)
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end
  end
end
