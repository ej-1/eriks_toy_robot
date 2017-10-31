require 'spec_helper'
require 'rails_helper'
require 'toy_robot.rb'
require 'command_runner.rb'

RSpec.describe CommandRunner, 'CommandRunner' do

  describe 'run PLACE command' do

    before do
      @toy_robot = ToyRobot.new
      @command_runner = CommandRunner.new
    end

    context 'as initial commmand' do
      it 'places and reports toy_robot position and facing' do
        @command_runner.run_command('place 0,3,west', @toy_robot)
        STDOUT.should_receive(:puts).with([0, 3, "west"])
        @command_runner.run_command('report', @toy_robot)
      end
    end

    context 'as a subsequent commmand' do
      it 'places and reports toy_robot position and facing' do
        @command_runner.run_command('move', @toy_robot)
        @command_runner.run_command('left', @toy_robot)
        @command_runner.run_command('right', @toy_robot)
        @command_runner.run_command('move', @toy_robot)
        expect(@toy_robot.position_and_facing).to eq(nil)
        @command_runner.run_command('place 0,3,east', @toy_robot)
        STDOUT.should_receive(:puts).with([0, 3, "east"])
        @command_runner.run_command('report', @toy_robot)
      end
    end
  end

  describe 'Commands sent to ToyRobot that is off table' do

    before do
      @toy_robot = ToyRobot.new
      @command_runner = CommandRunner.new
    end

    context 'robot is outside of table x-axis' do
      it 'ignores MOVE, LEFT, RIGHT and REPORT commands' do
        @command_runner.run_command('place 6,0,east', @toy_robot)
        @command_runner.run_command('move', @toy_robot)
        @command_runner.run_command('left', @toy_robot)
        @command_runner.run_command('right', @toy_robot)
        expect(@toy_robot.position_and_facing).to eq({:x=>6, :y=>0, :facing=>"east"})
      end
    end

    context 'robot is outside of table y-axis' do
      it 'ignores MOVE, LEFT, RIGHT and REPORT commands' do
        @command_runner.run_command('place 0,6,east', @toy_robot)
        @command_runner.run_command('move', @toy_robot)
        @command_runner.run_command('left', @toy_robot)
        @command_runner.run_command('right', @toy_robot)
        expect(@toy_robot.position_and_facing).to eq({:x=>0, :y=>6, :facing=>"east"})
      end
    end
  end

  describe 'run LEFT command' do

    before do
      @toy_robot = ToyRobot.new
      @command_runner = CommandRunner.new
    end

    {
      'north' => 'west',
      'east' => 'north',
      'west' => 'west',
      'south' => 'west'
    }.each do |facing, direction|
      context "facing #{facing.upcase}" do
        it 'turns to the left' do
          @command_runner.run_command("place 0,0,#{facing}", @toy_robot)
          @command_runner.run_command('left', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq({:x=>0, :y=>0, :facing=>"#{direction}"})
        end
      end
    end
  end

  describe 'run RIGHT command' do

    before do
      @toy_robot = ToyRobot.new
      @command_runner = CommandRunner.new
    end

    {
      'north' => 'east',
      'east' => 'east',
      'west' => 'south',
      'south' => 'east'
    }.each do |facing, direction|
      context "facing #{facing.upcase}" do
        it 'turns to the left' do
          @command_runner.run_command("place 0,0,#{facing}", @toy_robot)
          @command_runner.run_command('right', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq({:x=>0, :y=>0, :facing=>"#{direction}"})
        end
      end
    end
  end

  describe 'run MOVE command' do

    before do
      @toy_robot = ToyRobot.new
      @command_runner = CommandRunner.new
    end

    context 'positioned on table, at border facing EAST' do
      [
        ['5,0,east', {:x=>5, :y=>0, :facing=>"east"}],
        ['5,5,east', {:x=>5, :y=>5, :facing=>"east"}],
        ['5,2,east', {:x=>5, :y=>2, :facing=>"east"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, NOT at border, facing EAST' do
      [
        ['2,0,east', {:x=>3, :y=>0, :facing=>"east"}],
        ['2,5,east', {:x=>3, :y=>5, :facing=>"east"}],
        ['2,2,east', {:x=>3, :y=>2, :facing=>"east"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, at border facing WEST' do
      [
        ['0,0,west', {:x=>0, :y=>0, :facing=>"west"}],
        ['0,5,west', {:x=>0, :y=>5, :facing=>"west"}],
        ['0,2,west', {:x=>0, :y=>2, :facing=>"west"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, NOT at border, facing WEST' do
      [
        ['2,0,west', {:x=>1, :y=>0, :facing=>"west"}],
        ['2,5,west', {:x=>1, :y=>5, :facing=>"west"}],
        ['2,2,west', {:x=>1, :y=>2, :facing=>"west"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, at border facing NORTH' do
      [
        ['0,5,north', {:x=>0, :y=>5, :facing=>"north"}],
        ['5,5,north', {:x=>5, :y=>5, :facing=>"north"}],
        ['2,5,north', {:x=>2, :y=>5, :facing=>"north"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, NOT at border, facing NORTH' do
      [
        ['0,2,north', {:x=>0, :y=>3, :facing=>"north"}],
        ['5,2,north', {:x=>5, :y=>3, :facing=>"north"}],
        ['2,2,north', {:x=>2, :y=>3, :facing=>"north"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, at border facing SOUTH' do
      [
        ['0,0,south', {:x=>0, :y=>0, :facing=>"south"}],
        ['5,0,south', {:x=>5, :y=>0, :facing=>"south"}],
        ['2,0,south', {:x=>2, :y=>0, :facing=>"south"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end

    context 'positioned on table, NOT at border, facing SOUTH' do
      [
        ['0,2,south', {:x=>0, :y=>1, :facing=>"south"}],
        ['5,2,south', {:x=>5, :y=>1, :facing=>"south"}],
        ['2,2,south', {:x=>2, :y=>1, :facing=>"south"}],
      ].each do |input, output|
        it 'receives MOVE command' do
          @command_runner.run_command("place #{input}", @toy_robot)
          @command_runner.run_command('move', @toy_robot)
          expect(@toy_robot.position_and_facing).to eq(output)
        end
      end
    end
  end
end
