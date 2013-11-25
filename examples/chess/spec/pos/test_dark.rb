require 'spec_helper'
module Chess
  describe Pos, 'dark?' do

    it 'works as expected on non dark cells' do
      Pos.algebraic("1B").should_not be_dark
      Pos.algebraic("2C").should_not be_dark
    end

    it 'works as expected on dark cells' do
      Pos.algebraic("1A").should be_dark
      Pos.algebraic("2B").should be_dark
    end

  end
end
