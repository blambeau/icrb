module ICRb
  class Color
    include ICRb::ADT

    def initialize(r, g, b)
      @r, @g, @b = r, g, b
    end
    attr_reader :r, :g, :b

    ic :triple, Array do

      def alpha(array)
        Color.new(*array)
      end

      def omega(color)
        [color.r, color.g, color.b]
      end

    end # ic Array

    ic :hex, String, /^#[0-9a-f]{6}/i do

      def alpha(s)
        Color.triple [1, 3, 5].map{|i| s[i, 2].to_i(16) }
      end

      def omega(color)
        "#" << color.to_triple.map{|i| i.to_s(16) }.join
      end

    end # ic String

    ic :rgb, Tuple[r: Integer, g: Integer, b: Integer] do

      def alpha(tuple)
        Color.new(tuple.r, tuple.g, tuple.b)
      end

      def omega(color)
        infotype.new(r: color.r, g: color.g, b: color.b)
      end

    end # ic Tuple[r, g, b]

    def to_s
      "Color(#{to_hex})"
    end

  end # class Color
end # module ICRb
