require 'spec_helper'
module Chess
  describe Board, 'dress' do

    let(:input){ (Path.dir/'board.json').load }

    subject{ Board.dress(input) }

    it{ should be_a(Board) }

    it 'should have the pieces' do
      subject.pieces.reject(&:nil?).size.should eq(23)
    end

  end
end
