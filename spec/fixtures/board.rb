class Board
  include ICRb::ADT

  def initialize(rel)
    @rel = rel
  end
  attr_reader :rel

  ic Relation[pos: Integer] do

    def alpha(relation)
      Board.new relation.extend(pos: ->(t){ t.pos*2 })
    end

    def omega(board)
      board.rel.extend(pos: ->(t){ t.pos / 2 })
    end

  end
  
end