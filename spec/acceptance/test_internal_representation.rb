require 'spec_helper'
module ICRb
  describe "Using a particular IC as internal representation" do

    class WithInternalRepresentationAndNoDressMethods
      include ICRb::Datatype

      ic :rep, String, ->(s){ s =~ /^[1-9]+$/ }, internal: true

    end # class WithInternalRepresentationAndNoDressMethods

    it 'should install a constructor' do
      adt = WithInternalRepresentationAndNoDressMethods.new("123")
      adt.should be_a(WithInternalRepresentationAndNoDressMethods)
    end

    it 'should install equality operators' do
      wir1 = WithInternalRepresentationAndNoDressMethods.new("123")
      wir2 = WithInternalRepresentationAndNoDressMethods.new("123")
      (wir1 == wir2).should be_true
      (wir1.eql?(wir2)).should be_true
    end

    it 'should install a hash method' do
      wir1 = WithInternalRepresentationAndNoDressMethods.new("123")
      wir1.hash.should eq("123".hash)
    end

    it 'should install dress/undress also' do
      wir = WithInternalRepresentationAndNoDressMethods.dress("123")
      wir.should be_a(WithInternalRepresentationAndNoDressMethods)
      unwir = WithInternalRepresentationAndNoDressMethods.undress(wir)
      unwir.should eq("123")
    end

  end
end
