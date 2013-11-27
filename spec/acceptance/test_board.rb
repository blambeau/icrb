require 'spec_helper'
module ICRb
  describe Board do

    let(:input){ Relation(pos: 1) }

    let(:board){ Board.dress(input) }

    it 'unnamed dress works' do
      board.should be_a(Board)
      board.rel.should eq(Relation(pos: 2))
    end

    it 'unnamed undress works' do
      Board.undress(board).should eq(input)
    end

  end
end
