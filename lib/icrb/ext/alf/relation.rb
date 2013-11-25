module Alf
  class Relation

    def self.alpha(array)
      unless Alf::RelationLike===array or Array===array
        raise ICRb::AlphaError, "Invalid input `#{array}` for #{self}"
      end

      type   = Tuple[heading]
      tuples = array.map{|t| type.alpha(t) }.to_set
      new(tuples)
    end

    def self.omega(rel)
      rel.to_a
    end

  end # class Relation
end # module Alf
