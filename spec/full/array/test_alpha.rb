require 'spec_helper'

describe Array, "dress" do

  let(:input){
    Relation[at: Integer, value: Object].coerce([
      {at: 1, value: "foo"},
      {at: 4, value: "bar"}
    ])
  }

  subject{ Array.dress(input) }

  it{ should eq([nil, "foo", nil, nil, "bar"]) }

end
