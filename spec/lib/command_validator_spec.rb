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
      expect(@object.parse_and_validate_input('PLACE f,b,layt')).to eq(['PLACE', nil])
    end
  end

  context 'CommandValidator receives valid input' do
    it 'receives PLACE input' do
      expect(@object.parse_and_validate_input('PLACE 0,3,WEST')).to eq(['PLACE', {:x=>0, :y=>3, :facing=>'WEST'}])
    end

    it 'receives MOVE command' do
      expect(@object.parse_and_validate_input('MOVE')).to eq(['MOVE', nil])
    end

    it 'receives REPORT command' do
      expect(@object.parse_and_validate_input('REPORT')).to eq(['REPORT', nil])
    end

    it 'receives RIGHT command' do
      expect(@object.parse_and_validate_input('RIGHT')).to eq(['RIGHT', nil])
    end

    it 'receives LEFT command' do
      expect(@object.parse_and_validate_input('LEFT')).to eq(['LEFT', nil])
    end
  end
end
