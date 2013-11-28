require 'spec_helper'
module ICRb
  describe Infotype, "===" do

    context 'without constraint' do
      let(:infotype){ Infotype[Integer] }

      it 'recognizes Integers' do
        (infotype === 12).should be_true
      end

      it 'rejects Strings' do
        (infotype === "foo").should be_false
      end
    end

    context 'with constraint as a block' do
      let(:infotype){ Infotype[Integer].such_that{|i| i<255 } }

      it 'recognizes valid Integers' do
        (infotype === 12).should be_true
      end

      it 'rejects invalid Integers' do
        (infotype === 1000).should be_false
      end
    end

    context 'with constraint as a matcher' do
      let(:infotype){ Infotype[Integer].such_that(0..255) }

      it 'recognizes valid Integers' do
        (infotype === 12).should be_true
      end

      it 'rejects invalid Integers' do
        (infotype === 1000).should be_false
      end
    end

  end
end
