require 'spec_helper'
module Chess
  describe Pos, 'algebraic information contract' do

    it 'works as expected' do
      Pos.algebraic("2E").row.should eq(1)
      Pos.algebraic("2E").col.should eq(4)
    end

    it 'is information consistent' do
      Pos.algebraic("2E").should eq(Pos.algebraic("2E"))
    end

    it 'is information complete' do
      Pos.algebraic("2E").to_algebraic.should eq("2E")
    end

    it 'recognizes bad values' do
      lambda{
        Pos.algebraic("9D")
      }.should raise_error(ICRb::DressError, "Invalid input `9D` for Chess::Pos.algebraic")
      lambda{
        Pos.algebraic("2I")
      }.should raise_error(ICRb::DressError, "Invalid input `2I` for Chess::Pos.algebraic")
    end

  end
end
