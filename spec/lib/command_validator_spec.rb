require 'spec_helper'
require 'rails_helper'
require 'command_validator.rb'

RSpec.describe CommandValidator, '#runs CommandValidator' do

  before do
    @object = Object.new
    @object.extend(CommandValidator)
  end

  context 'CommandValidator receives invalid input' do
    it 'receives gibberish input' do
      expect(@object.parse_and_validate_input('blabla 022isd,la')).to eq(nil)
    end

    it 'receives valid PLACE command with gibberish' do
      expect(@object.parse_and_validate_input('place f,b,layt')).to eq('place')
    end
  end

  context 'CommandValidator receives valid input' do
    it 'receives PLACE input' do
      expect(@object.parse_and_validate_input('place 0,3,west')).to eq(['place', ['0', '3', 'west']])
    end

    it 'receives MOVE command' do
      expect(@object.parse_and_validate_input('move')).to eq('move')
    end

    it 'receives REPORT command' do
      expect(@object.parse_and_validate_input('report')).to eq('report')
    end

    it 'receives RIGHT command' do
      expect(@object.parse_and_validate_input('right')).to eq('right')
    end

    it 'receives LEFT command' do
      expect(@object.parse_and_validate_input('left')).to eq('left')
    end
  end
end
