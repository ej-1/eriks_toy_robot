require 'spec_helper'
require 'rails_helper'
require 'toy_robot.rb'
require 'command_runner.rb'

RSpec.describe CommandRunner, 'CommandRunner' do

  describe 'run PLACE command' do

    before do
      @board = Board.new(4, 4)
      @command_runner = CommandRunner.new
    end

    context 'as initial commmand' do
      it 'PLACEs and reports toy_robot position and facing' do
        @command_runner.run_command('PLACE', {:x=>0, :y=>3, :facing=>"WEST"}, @board)
        STDOUT.should_receive(:puts).with([0, 3, 'WEST'])
        @command_runner.run_command('REPORT', nil, @board)
      end
    end

    context 'as a subsequent commmand' do
      # This spec is a bit more like a integration test.
      it 'PLACEs and reports toy_robot position and facing' do
        STDOUT.should_receive(:puts).with('NO TOY ROBOT HAS BEEN PLACED!').exactly(4).times
        @command_runner.run_command('MOVE', nil, @board)
        @command_runner.run_command('LEFT', nil, @board)
        @command_runner.run_command('RIGHT', nil, @board)
        @command_runner.run_command('MOVE', nil, @board)
        #expect(@toy_robot.position_and_facing).to eq(nil)
        @command_runner.run_command('PLACE', {:x=>0, :y=>3, :facing=>'WEST'}, @board)
        STDOUT.should_receive(:puts).with([0, 3, 'WEST'])
        @command_runner.run_command('REPORT', nil, @board)
      end
    end
  end

  describe 'Commands sent to ToyRobot that is off table' do

    before do
      @board = Board.new(4, 4)
      @command_runner = CommandRunner.new
    end

    context 'robot is outside of table x-axis' do
      it 'ignores MOVE, LEFT, RIGHT and REPORT commands' do
        @toy_robot = @command_runner.run_command('PLACE', {:x=>6, :y=>0, :facing=>'EAST'}, @board)
        @command_runner.run_command('MOVE', nil, @board)
        @command_runner.run_command('LEFT', nil, @board)
        @command_runner.run_command('RIGHT', nil, @board)
        expect(@toy_robot.x).to eq(6)
        expect(@toy_robot.y).to eq(0)
        expect(@toy_robot.facing).to eq('EAST')
      end
    end

    context 'robot is outside of table y-axis' do
      it 'ignores MOVE, LEFT, RIGHT and REPORT commands' do
        @toy_robot = @command_runner.run_command('PLACE', {:x=>0, :y=>6, :facing=>'EAST'}, @board)
        @command_runner.run_command('MOVE', nil, @board)
        @command_runner.run_command('LEFT', nil, @board)
        @command_runner.run_command('RIGHT', nil, @board)
        expect(@toy_robot.x).to eq(0)
        expect(@toy_robot.y).to eq(6)
        expect(@toy_robot.facing).to eq('EAST')
      end
    end
  end

  describe 'run LEFT command' do

    before do
      @board = Board.new(4, 4)
      @command_runner = CommandRunner.new
    end

    {
      'NORTH' => 'WEST',
      'WEST' => 'SOUTH',
      'SOUTH' => 'EAST',
      'EAST' => 'NORTH'
    }.each do |facing, direction|
      context "facing #{facing.upcase}" do
        it 'turns to the LEFT' do
          @toy_robot = @command_runner.run_command('PLACE', {:x=>0, :y=>4, :facing=>"#{facing}"}, @board)
          @command_runner.run_command('LEFT', nil, @board)
          expect(@toy_robot.x).to eq(0)
          expect(@toy_robot.y).to eq(4)
          expect(@toy_robot.facing).to eq("#{direction}")
        end
      end
    end
  end

  describe 'run RIGHT command' do

    before do
      @board = Board.new(4, 4)
      @command_runner = CommandRunner.new
    end

    {
      'NORTH' => 'EAST',
      'EAST' => 'SOUTH',
      'SOUTH' => 'WEST',
      'WEST' => 'NORTH'
    }.each do |facing, direction|
      context "facing #{facing.upcase}" do
        it 'turns to the RIGHT' do
          @toy_robot = @command_runner.run_command('PLACE', {:x=>0, :y=>4, :facing=>"#{facing}"}, @board)
          @command_runner.run_command('RIGHT', nil, @board)
          expect(@toy_robot.x).to eq(0)
          expect(@toy_robot.y).to eq(4)
          expect(@toy_robot.facing).to eq("#{direction}")
        end
      end
    end
  end

  describe 'run MOVE command' do

    before do
      @board = Board.new(4, 4)
      @command_runner = CommandRunner.new
    end

    context 'positioned on table, at border facing EAST' do
      [
        {:x=>4, :y=>0, :facing=>"EAST"},
        {:x=>4, :y=>5, :facing=>"EAST"},
        {:x=>4, :y=>2, :facing=>"EAST"},
      ].each do |position_data|
        it 'receives MOVE command' do
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
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
          @toy_robot = @command_runner.run_command('PLACE', position_data, @board)
          @command_runner.run_command('MOVE', nil, @board)
          expect(@toy_robot.x).to eq(position_data[:x])
          expect(@toy_robot.y).to eq(1)
          expect(@toy_robot.facing).to eq(position_data[:facing])
        end
      end
    end
  end
end
