require 'spec_helper'
module ICRb
  describe Infotype, "to_s" do

    let(:infotype){ Infotype[Fixnum].such_that{|i| i < 255 } }

    it 'returns something nice' do
      infotype.to_s.should eq("Fixnum{...}")
    end

  end
end
