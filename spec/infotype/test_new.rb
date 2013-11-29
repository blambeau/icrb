require 'spec_helper'
module ICRb
  describe Infotype, "new" do

    context 'without constraint' do
      let(:infotype){ Infotype[Array] }

      it 'returns an array' do
        infotype.new.class.should eq(Array)
      end
    end

    context 'with a constraint' do
      let(:infotype){ Infotype[Array].such_that{|arr| arr.size == 2 } }

      it 'returns an array too' do
        infotype.new.class.should eq(Array)
      end
    end

  end
end
