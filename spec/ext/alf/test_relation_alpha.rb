require 'spec_helper'
module Alf
  describe Relation, ".dress" do

    subject{ type.dress(input) }

    context 'through dress support' do
      let(:type){ Relation[color: ICRb::Color] }

      let(:input){[
        { "color" => "#ffc0cb" },
        { "color" => [255,192,203] }
      ]}

      it { should be_a(type) }

      it 'correctly filter duplicates' do
        subject.size.should be(1)
      end

      it 'coerces correctly' do
        subject.to_a.all?{|t| t[:color].should be_a(ICRb::Color) }
      end
    end

  end
end
