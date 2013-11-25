module Alf
  class Tuple

    def self.alpha(hash)
      unless Alf::TupleLike===hash
        raise ICRb::AlphaError, "Invalid input `#{hash}` for #{self}"
      end

      coerced = Hash[heading.map{|name,datatype|
        value = hash[name] || hash[name.to_s] || hash[name.to_sym]
        value = datatype.alpha(value) unless value.is_a?(datatype)
        [ name.to_sym, value ]
      }]
      new(coerced)
    end

    def self.omega(tuple)
      tuple.to_hash
    end

  end # class Tuple
end # module Alf
