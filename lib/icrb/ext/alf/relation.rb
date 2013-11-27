module Alf
  class Relation

    def self.dress(array)
      unless Alf::RelationLike===array or Array===array
        raise ICRb::DressError, "Invalid input `#{array}` for #{self}"
      end

      if respond_to?(:heading)
        type   = Tuple[heading]
        tuples = array.map{|t| type.dress(t) }.to_set
        new(tuples)
      else
        coerce(array)
      end
    end

    def self.undress(rel)
      rel.to_a
    end

  end # class Relation
end # module Alf
