require 'spec_helper'
module ICRb
  describe "Using specialization by constraint" do

    class WithSByCContract
      include ICRb::Datatype

      def initialize(rep)
        @rep = rep
      end
      attr_reader :rep

      ic :inline, String, /^[1-9]+$/, ->(s){ s.length > 2 } do
        def dress(s)
          WithSByCContract.new(s)
        end
        def undress(wim)
          wim.rep
        end
      end

      ic :byte, Infotype[Integer].such_that{|i|  i>0 and i<255 } do
        def dress(s)
          WithSByCContract.new(s)
        end
        def undress(wim)
          wim.rep
        end
      end

    end # class WithSByCContract

    describe 'inline IC' do

      it 'accepts valid strings' do
        WithSByCContract.inline("123").should be_a(WithSByCContract)
      end

      it 'rejects invalid strings' do
        lambda{
          WithSByCContract.inline("abc")
        }.should raise_error(DressError, "Invalid input `abc` for ICRb::WithSByCContract.inline")
      end

      it 'rejects strings to short' do
        lambda{
          WithSByCContract.inline("1")
        }.should raise_error(DressError, "Invalid input `1` for ICRb::WithSByCContract.inline")
      end
    end

    describe 'through byte Infotype' do

      it 'accepts valid bytes' do
        WithSByCContract.byte(123).should be_a(WithSByCContract)
      end

      it 'rejects negative bytes' do
        lambda{
          WithSByCContract.byte(-1)
        }.should raise_error(DressError, "Invalid input `-1` for ICRb::WithSByCContract.byte")
      end

      it 'rejects too large bytes' do
        lambda{
          WithSByCContract.byte(256)
        }.should raise_error(DressError, "Invalid input `256` for ICRb::WithSByCContract.byte")
      end
    end

  end
end
