require 'spec_helper'
module Chess
  describe Board, 'dress' do

    let(:input){ (Path.dir/'board.json').load }

    let(:board){ Board.dress(input) }

    subject{ Board.undress(board) }

    it{ should be_a(Relation) }

  end
end
