require 'spec_helper'
require 'commands/report.rb'
require 'toy_robot.rb'
require 'board.rb'
require 'pry'

RSpec.describe Report, '#runs Report command' do

  before do
    @board = Board.new(4, 4)
  end

  context 'toy_robot placed on table' do

    it 'turns outputs' do
      @toy_robot = ToyRobot.new({:x=>0, :y=>3, :facing=>'EAST', :board=>@board})
      STDOUT.should_receive(:puts).with([0, 3, 'EAST'])
      Report.execute(@toy_robot)
    end
  end

  context 'toy_robot not placed on table' do

    it 'ignores Place command' do
      @toy_robot = ToyRobot.new({:x=>0, :y=>5, :facing=>'EAST', :board=>@board})
      STDOUT.should_receive(:puts).exactly(0).times
      Report.execute(@toy_robot)
    end
  end
end
