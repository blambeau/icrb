require 'spec_helper'
module Chess
  describe Board, 'to_json and back' do

    let(:input){ (Path.dir/'board.json').load }
    let(:board){ Board.dress(input) }

    subject{ board.to_json }

    it 'should allow a roundtrip' do
      Board.dress(::JSON.load(subject)).should eq(board)
    end

  end
end
