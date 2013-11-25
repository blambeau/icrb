require 'spec_helper'

describe Array, "omega" do

  let(:input){
    [nil, "foo", nil, nil, "bar"]
  }

  let(:expected){
    Relation[at: Integer, value: Object].coerce([
      {at: 1, value: "foo"},
      {at: 4, value: "bar"}
    ])
  }

  subject{ Array.omega(input) }

  it{ should eq(expected) }

end
