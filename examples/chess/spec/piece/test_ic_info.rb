require 'spec_helper'
module Chess
  describe Piece, 'information contract' do

    let(:hash){ {kind: "pawn", color: "dark"} }

    it 'works as expected' do
      Piece.info(hash).should be_a(Piece::Pawn)
      Piece.info(hash).kind.should eq("pawn")
      Piece.info(hash).color.should eq("dark")
    end

    it 'is information complete' do
      Piece.info(hash).to_info.should eq(Tuple(hash))
    end

    it 'recognizes bad values' do
    end

  end
end
