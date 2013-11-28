require 'spec_helper'
module ICRb
  describe "Using an invariant method" do

    class WithInvariantMethod
      include ICRb::Datatype

      def initialize(rep)
        @rep = rep
      end

      ic String do

        def valid?(s)
          s =~ /^[0-9]+$/
        end

        def dress(s)
          WithInvariantMethod.new(s)
        end

        def undress(wim)
          wim.to_s
        end

      end # ic String

    end # class WithInvariantMethod

    it 'should detect invalid infovalues' do
      lambda{
        WithInvariantMethod.dress('foo')
      }.should raise_error(DressError)
    end

    it 'should let valid infovalues pass' do
      lambda{
        WithInvariantMethod.dress('123')
      }.should_not raise_error
    end

  end
end
