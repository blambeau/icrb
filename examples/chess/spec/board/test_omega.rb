require 'spec_helper'
module Chess
  describe Board, 'alpha' do

    let(:input){ (Path.dir/'board.json').load }

    let(:board){ Board.alpha(input) }

    subject{ Board.omega(board) }

    it{ should be_a(Relation) }

  end
end
