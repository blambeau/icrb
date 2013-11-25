require 'spec_helper'
describe ICRb do

  it "should have a version number" do
    ICRb.const_defined?(:VERSION).should be_true
  end

end
