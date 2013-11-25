require 'spec_helper'
module Chess
  describe Pos, 'rowcol information contract' do

    let(:hash){ {row: 1, col: 5} }

    it 'works as expected' do
      Pos.rowcol(hash).row.should eq(1)
      Pos.rowcol(hash).col.should eq(5)
    end

    it 'is information consistent' do
      Pos.rowcol(hash).should eq(Pos.rowcol(hash))
    end

    it 'is information complete' do
      Pos.rowcol(hash).to_rowcol.should eq(Tuple(hash))
    end

  end
end
