require 'spec_helper'
module Alf
  class Algebra::Down::Omegaization
    describe ArrayBased, "to_heading" do

      let(:omg){ ArrayBased.new([:color]) }

      subject{ omg.to_heading(Heading[pos: Integer, color: ICRb::Color]) }

      it{
        should eq(Heading[pos: Integer, color: Array])
      }

    end
  end
end
