module Chess
  class Board
    include ICRb::ADT

    def initialize(pieces = Array.new(64))
      @pieces = pieces
    end
    attr_reader :pieces

    def piece_at(pos)
      @pieces[pos.to_linear]
    end

    ic :relation, Relation[pos: Pos, piece: Piece] do

      def alpha(rel)
        Board.new(Array.alpha(rel.omega(pos: :linear).rename(pos: :at, piece: :value)))
      end

      def omega(board)
        datatype.alpha(Array.omega(board.pieces).rename(at: :pos, value: :piece))
      end

    end # ic info

    def to_s
      sepline = "   " << ("+" + "-"*8)*8 << "+" << "\n"
      empty   = "   " << ("+" + " "*8)*8 << "+" << "\n"
      buffer  = ""
      buffer << "   " << ("A".."H").map{|l| " "*5 << l << " "*3 }.join << "\n"
      (0..7).each do |row|
        buffer << sepline << empty
        buffer << "#{1+row}  "
        (0..7).each do |col|
          buffer << "+ "
          piece = piece_at(Pos.rowcol(row: row, col: col))
          to_s  = (piece && piece.to_short_s || " "*6)
          buffer << to_s << " "
        end
        buffer << "+\n" << empty
      end
      buffer << sepline
      buffer
    end

  end # class Board
end # module Chess
