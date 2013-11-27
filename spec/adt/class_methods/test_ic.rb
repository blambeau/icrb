require 'spec_helper'

module ICRb
  module ADT
    describe ClassMethods, 'ic' do

      let(:cm){ Class.new.extend(ClassMethods) }

      let(:precondition){ ->(t){ false } }

      after do
        subject.should be_a(Base)
      end

      context 'when all args' do
        subject{ cm.ic(:hex, String, precondition, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(:hex)
          subject.datatype.should be(String)
          subject.precondition.should be(precondition)
          subject.options.should eq(accessors: true, foo: :bar)
        end
      end

      context 'without name' do
        subject{ cm.ic(String, precondition, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(Unset)
          subject.datatype.should be(String)
          subject.precondition.should be(precondition)
          subject.options.should eq(accessors: false, foo: :bar)
        end
      end

      context 'with a Regexp precondition' do
        subject{ cm.ic(:hex, String, /[A-Z]+/, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(:hex)
          subject.datatype.should be(String)
          subject.precondition.should be_a(Regexp)
          subject.options.should eq(accessors: true, foo: :bar)
        end
      end

      context 'when setting accessors to false' do
        subject{ cm.ic(:hex, String, precondition, accessors: false, foo: :bar) }

        it 'should have all correctly set' do
          subject.name.should eq(:hex)
          subject.datatype.should be(String)
          subject.precondition.should be(precondition)
          subject.options.should eq(accessors: false, foo: :bar)
        end
      end

    end
  end
end
