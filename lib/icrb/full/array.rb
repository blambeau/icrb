class Array

  ic :facts, Relation[at: Integer, value: Object] do

    def alpha(rel)
      array = Array.new(rel.size)
      rel.each{|tuple| array[tuple.at] = tuple.value }
      array
    end

    def omega(array)
      type   = Tuple[datatype.heading]
      tuples = Set.new
      array.each_with_index.each{|val,i|
        tuples << type.alpha(at: i, value: val) unless val.nil?
      }
      datatype.new(tuples)
    end

  end

end # class Array
