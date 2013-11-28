require 'spec_helper'
module Alf
  class Algebra::Down::Omegaization
    describe HashBased, "to_heading" do

      let(:omg){ HashBased.new(:color => :hex) }

      subject{ omg.to_heading(Heading[pos: Integer, color: ICRb::Color]) }

      pending{
        it{
          should eq(Heading[pos: Integer, color: String])
        }
      }

    end
  end
end
