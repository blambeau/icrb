require 'spec_helper'
require 'json'
module Chess
  describe Pos, 'to_json' do

    subject{ Pos.algebraic("1B").to_json }

    it 'should lead to expected resut' do
      ::JSON.load(subject).should eq("row" => 0, "col" => 1)
    end

  end
end
