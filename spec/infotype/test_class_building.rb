require 'spec_helper'
module ICRb
  describe Infotype, ".[]" do

    subject{ Infotype[Fixnum] }

    it 'returns an infotype' do
      subject.should be_a(Infotype)
    end

  end
end
