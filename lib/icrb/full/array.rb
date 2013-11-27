class Array
  extend ICRb::Datatype::ClassMethods

  ic :facts, Relation[at: Integer, value: Object] do

    def dress(rel)
      array = Array.new(rel.size)
      rel.each{|tuple| array[tuple.at] = tuple.value }
      array
    end

    def undress(array)
      type   = Tuple[infotype.heading]
      tuples = Set.new
      array.each_with_index.each{|val,i|
        tuples << type.dress(at: i, value: val) unless val.nil?
      }
      infotype.new(tuples)
    end

  end

end # class Array
