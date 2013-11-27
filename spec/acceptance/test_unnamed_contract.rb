require 'spec_helper'
module ICRb
  describe "Using an unnamed contract" do

    class WithUnnamedContract
      include ICRb::Datatype

      def initialize(rep)
        @rep = rep
      end
      attr_reader :rep

      ic String do

        def valid?(s)
          s =~ /^[0-9]+$/
        end

        def dress(s)
          WithUnnamedContract.new(s)
        end

        def undress(wim)
          wim.to_s
        end

      end # ic String

    end # class WithUnnamedContract

    it 'should still work' do
      WithUnnamedContract.dress('123').rep.should eq("123")
    end

    it 'should not install a .default class method' do
      WithUnnamedContract.should_not respond_to(:default)
    end

    it 'should not install a to_default instance method' do
      WithUnnamedContract.new('123').should_not respond_to(:to_default)
    end
  end
end