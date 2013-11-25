require 'spec_helper'
module Chess
  describe Pos, 'light?' do

    it 'works as expected on light cells' do
      Pos.algebraic("1B").should be_light
      Pos.algebraic("2C").should be_light
    end

    it 'works as expected on non light cells' do
      Pos.algebraic("1A").should_not be_light
      Pos.algebraic("2B").should_not be_light
    end

  end
end
