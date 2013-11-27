module Chess
  class Piece
    include ICRb::Datatype

    def initialize(color)
      @color = color
    end
    attr_reader :color

    # TODO: make this secure
    ic :info, Tuple[kind: String, color: String] do

      def dress(tuple)
        Piece.const_get(tuple.kind.capitalize).new(tuple.color)
      end

      def undress(piece)
        infotype.new(kind: piece.kind, color: piece.color)
      end

    end # ic Tuple[kind, color]

    def kind
      self.class.name.to_s[/::([A-Za-z]+)$/, 1].downcase
    end

    def to_short_s
      "#{kind[0, 3].capitalize}(#{color[0,1]})"
    end

    def to_s
      "#{color} #{kind.capitalize}"
    end

    class King < Piece
    end # class King

    class Queen < Piece
    end # class Queen

    class Rook < Piece
    end # class Rook

    class Bishop < Piece
    end # class Rook

    class Knight < Piece
    end # class Rook

    class Pawn < Piece
    end # class Rook

  end # class Piece
end # module Chess
