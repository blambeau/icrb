require 'spec_helper'

describe Array, "alpha" do

  let(:input){
    Relation[at: Integer, value: Object].coerce([
      {at: 1, value: "foo"},
      {at: 4, value: "bar"}
    ])
  }

  subject{ Array.alpha(input) }

  it{ should eq([nil, "foo", nil, nil, "bar"]) }

end
