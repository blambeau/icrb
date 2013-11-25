require 'spec_helper'
module Alf
  describe Relation, 'down' do

    let(:rel){
      Relation([
        { color: ICRb::Color.triple([255,192,203]) }
      ])
    }

    context 'with a hash' do
      subject{ rel.down(color: :hex) }

      pending do
        it 'should have expected heading' do
          subject.heading.should eq(Heading[color: String])
        end

        it{ should be_a(Relation[color: String]) }
      end

      it 'should be as expected' do
        subject.tuple_extract[:color].should be_a(String)
        subject.tuple_extract[:color].should eq("#ffc0cb")
      end
    end

    context 'with a list of symbols' do
      subject{ rel.down([:color]) }

      pending do
        it 'should have expected heading' do
          subject.heading.should eq(Heading[color: Array])
        end

        it{ should be_a(Relation[color: Array]) }
      end

      it 'should be as expected' do
        subject.tuple_extract[:color].should be_a(Array)
        subject.tuple_extract[:color].should eq([255,192,203])
      end
    end

  end
end
