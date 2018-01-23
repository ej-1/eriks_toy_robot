require 'spec_helper'
require 'rails_helper'
require 'position_data_validator.rb'

RSpec.describe PositionDataValidator, 'PositionDataValidator' do

  before do
    @object = Object.new
    @object.extend(PositionDataValidator)
  end

  context 'receives correct input' do
    ['NORTH','EAST','WEST', 'SOUTH'].each do |direction|
      it "receives correct input with direction #{direction}" do
        expect(@object.valid_position_data?(['0','0',direction])).to eq(true)
      end
    end
  end

  context 'PositionDataValidator receives invalid input' do
    [
      ['0','0','bla'],
      ['342','232','123'],
      ['bla','pog','blr','bsq'],
      ['1','2','3','4'],
    ].each do |position_array|
      it "receives #{position_array}" do
        expect(@object.valid_position_data?(position_array)).to eq(false)
      end
    end
  end
end
