require 'spec_helper'

module ICRb
  describe Integer do

    describe 'the literal IC' do
      it 'should not have accessors' do
        Integer.should_not respond_to(:literal)
        1.should_not respond_to(:to_literal)
      end

      it 'should have the literal contract by default' do
        Integer.dress("12").should eq(12)
        Integer.undress(12).should eq("12")
      end

      it 'should accept zero' do
        Integer.dress("0").should eq(0)
        Integer.undress(0).should eq("0")
      end

      it 'should accept negative integers' do
        Integer.dress("-12").should eq(-12)
        Integer.undress(-12).should eq("-12")
      end

      it 'should recognize invalid literals' do
        lambda{
          Integer.dress("abc")
        }.should raise_error(AlphaError, "Invalid input `abc` for Integer.literal")
      end

    end

  end
end
