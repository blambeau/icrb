module Alf
  class Relation

    def self.alpha(array)
      unless Alf::RelationLike===array or Array===array
        raise ICRb::AlphaError, "Invalid input `#{array}` for #{self}"
      end

      if respond_to?(:heading)
        type   = Tuple[heading]
        tuples = array.map{|t| type.alpha(t) }.to_set
        new(tuples)
      else
        coerce(array)
      end
    end

    def self.omega(rel)
      rel.to_a
    end

  end # class Relation
end # module Alf
