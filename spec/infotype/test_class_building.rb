require 'spec_helper'
module ICRb
  describe Infotype, ".[]" do

    subject{ Infotype[Fixnum] }

    it 'returns a subclass of Fixnum' do
      subject.should be_a(Class)
      subject.superclass.should be(Fixnum)
    end

    it 'returns an infotype' do
      subject.should be_a(Infotype)
    end

  end
end
