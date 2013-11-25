module Chess
  class Pos

    def initialize(row, col)
      @row, @col = row, col
    end
    attr_reader :row, :col

    ic :rowcol, Tuple[row: Integer, col: Integer] do

      def alpha(tuple)
        Pos.new(tuple.row, tuple.col)
      end

      def omega(pos)
        datatype.alpha(row: pos.row, col: pos.col)
      end

    end # ic Tuple[row, col]

    ic :linear, Integer, ->(i){ i>=0 && i<=63 } do

      def alpha(i64)
        Pos.rowcol(row: i64 / 8, col: i64 % 8)
      end

      def omega(pos)
        pos.row*8 + pos.col
      end

    end # ic Integer

    ic :algebraic, String, ->(s){ s =~ /^[1-8][A-H]$/ } do

      def alpha(s)
        Pos.rowcol(row: s[0, 1].to_i - 1, col: s[1, 1].ord - 65)
      end

      def omega(pos)
        "#{1+pos.row}#{(65+pos.col).chr}"
      end

    end # ic String

    def dark?
      (col % 2) == (row % 2)
    end

    def light?
      !dark?
    end

    def hash
      row + 37*col
    end

    def ==(other)
      other.is_a?(Pos) && (other.row == self.row) && (other.col == self.col)
    end
    alias :eql? :==

    def to_s
      "Pos(#{to_algebraic})"
    end

  end # class Pos
end # module Chess
