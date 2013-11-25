require 'spec_helper'
module ICRb
  describe "The general principle" do
    describe "Color" do
      let(:color){ Color.new(255,192,203) }

      describe 'to_hex' do
        subject{ color.to_hex }

        it { should eq("#ffc0cb") }
      end

      describe '.hex' do

        context 'with a valid string' do
          subject{ Color.hex("#ffc0cb") }

          it{ should be_a(Color) }
          it{ should eq(color) }
        end

        context 'with an invalid string' do
          subject{ Color.hex("#gyc0cb") }

          it 'should raise an error' do
            lambda{
              subject
            }.should raise_error(AlphaError, "Invalid input `#gyc0cb` for ICRb::Color.hex")
          end
        end
      end

      describe 'to_triple' do
        subject{ color.to_triple }

        it { should eq([255,192,203]) }
      end

      describe '.triple' do
        subject{ Color.triple([255,192,203]) }

        it{ should be_a(Color) }
        it{ should eq(color) }
      end

      describe 'to_rgb' do
        subject{ color.to_rgb }

        it { should be_a(Tuple) }
        it { should eq(Tuple(r: 255, g: 192, b: 203)) }
      end

      describe '.rgb' do
        subject{ Color.rgb(Tuple(r: 255, g: 192, b: 203)) }

        it{ should be_a(Color) }
        it{ should eq(color) }
      end

      describe '.alpha' do
        subject{ Color.alpha(arg) }

        context 'with a String' do
          let(:arg){ "#ffc0cb" }

          it{ should eq(color) }
        end

        context 'with an Array' do
          let(:arg){ [255,192,203] }

          it{ should eq(color) }
        end

        context 'with a Tuple' do
          let(:arg){ Tuple(r: 255, g: 192, b: 203) }

          it{ should eq(color) }
        end

        context 'with a Hash' do
          let(:arg){ {r: 255, g: 192, b: 203} }

          it{ should eq(color) }
        end
      end

      describe '.omega' do
        subject{ Color.omega(color) }

        it{ should eq([255,192,203]) }
      end

      describe 'hash' do
        subject{ color.hash }

        it 'delegates to the first ic' do
          subject.should eq([255,192,203].hash)
        end
      end

      describe '==' do
        subject{ Color.omega(color) == Color.omega(color) }

        it{ should be_true }
      end

      describe 'to_json' do
        subject{ color.to_json }

        it 'delegates to the first ic' do
          subject.should eq([255,192,203].to_json)
        end

        it 'allows a roundtrip' do
          Color.alpha(::JSON.load(subject)).should eq(color)
        end
      end

      describe 'to_yaml' do
        subject{ color.to_yaml }

        it 'delegates to the first ic' do
          subject.should eq([255,192,203].to_yaml)
        end

        it 'allows a roundtrip' do
          Color.alpha(::YAML.load(subject)).should eq(color)
        end
      end

    end
  end
end