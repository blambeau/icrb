require 'spec_helper'

describe Array, "undress" do

  let(:input){
    [nil, "foo", nil, nil, "bar"]
  }

  let(:expected){
    Relation[at: Integer, value: Object].coerce([
      {at: 1, value: "foo"},
      {at: 4, value: "bar"}
    ])
  }

  subject{ Array.undress(input) }

  it{ should eq(expected) }

end
