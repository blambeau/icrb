require 'spec_helper'
module Chess
  describe Board, 'information contract' do

    let(:input){
      [
        {pos: "1C", piece: {kind: "pawn", color: "dark"}},
        {pos: "3E", piece: {kind: "king", color: "light"}},
      ]
    }

    it 'works as expected' do
      Board.dress(input).should be_a(Board)
    end

    it 'is information consistent' do
      Board.dress(input).should eq(Board.dress(input))
    end

  end
end
