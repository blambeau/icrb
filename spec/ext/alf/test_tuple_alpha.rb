require 'spec_helper'
module Alf
  describe Tuple, ".dress" do

    subject{ type.dress(input) }

    context 'when no coercion needed' do
      let(:type){ Tuple[pos: Integer] }

      let(:input){ { "pos" => 10 } }

      it { should be_a(type) }

      it{ should eq(type.coerce(pos: 10)) }
    end

    context 'when coercion needed' do
      let(:type){ Tuple[color: ICRb::Color] }

      let(:input){ { color: [255,192,203] } }

      it { should be_a(type) }

      it 'should have expected color' do
        subject.color.should be_a(ICRb::Color)
        subject.color.to_hex.should eq("#ffc0cb")
      end
    end

  end
end
