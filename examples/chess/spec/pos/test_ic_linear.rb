require 'spec_helper'
module Chess
  describe Pos, 'linear information contract' do

    it 'works as expected' do
      Pos.linear(13).row.should eq(1)
      Pos.linear(13).col.should eq(5)
    end

    it 'is information consistent' do
      Pos.linear(13).should eq(Pos.linear(13))
    end

    it 'is information complete' do
      Pos.linear(13).to_linear.should eq(13)
    end

    it 'recognizes bad values' do
      lambda{
        Pos.linear(-10)
      }.should raise_error(ICRb::DressError, "Invalid input `-10` for Chess::Pos.linear")
      lambda{
        Pos.linear(64)
      }.should raise_error(ICRb::DressError, "Invalid input `64` for Chess::Pos.linear")
    end

  end
end
