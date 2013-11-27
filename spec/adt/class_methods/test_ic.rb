require 'spec_helper'

module ICRb
  module ADT
    describe ClassMethods, 'ic' do

      let(:cm){ Class.new.extend(ClassMethods) }

      let(:invariant){ ->(t){ false } }

      after do
        subject.should be_a(Contract)
      end

      context 'when all args' do
        subject{ cm.ic(:hex, String, invariant, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(:hex)
          subject.infotype.should be(String)
          subject.invariant.should be(invariant)
          subject.options.should eq(accessors: true, foo: :bar)
        end
      end

      context 'without name' do
        subject{ cm.ic(String, invariant, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(Unset)
          subject.infotype.should be(String)
          subject.invariant.should be(invariant)
          subject.options.should eq(accessors: false, foo: :bar)
        end
      end

      context 'with a Regexp invariant' do
        subject{ cm.ic(:hex, String, /[A-Z]+/, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(:hex)
          subject.infotype.should be(String)
          subject.invariant.should be_a(Regexp)
          subject.options.should eq(accessors: true, foo: :bar)
        end
      end

      context 'when setting accessors to false' do
        subject{ cm.ic(:hex, String, invariant, accessors: false, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(:hex)
          subject.infotype.should be(String)
          subject.invariant.should be(invariant)
          subject.options.should eq(accessors: false, foo: :bar)
        end
      end

    end
  end
end
