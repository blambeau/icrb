class Board
  include ICRb::Datatype

  def initialize(rel)
    @rel = rel
  end
  attr_reader :rel

  ic Relation[pos: Integer] do

    def dress(relation)
      Board.new relation.extend(pos: ->(t){ t.pos*2 })
    end

    def undress(board)
      board.rel.extend(pos: ->(t){ t.pos / 2 })
    end

  end
  
end