require 'spec_helper'
module Alf
  describe Relation, 'up' do

    let(:rel){
      Relation([
        { color: [255,192,203] }
      ])
    }

    subject{ rel.up(color: ICRb::Color) }

    it 'should have expected heading' do
      subject.heading.should eq(Heading[color: ICRb::Color])
    end

    pending{
      it{
        should be_a(Relation[color: ICRb::Color])
      }
    }

    it 'should be as expected' do
      subject.tuple_extract[:color].should be_a(ICRb::Color)
      subject.tuple_extract[:color].to_hex.should eq("#ffc0cb")
    end

  end
end
