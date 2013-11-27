module Alf
  class Tuple

    def self.dress(hash)
      unless Alf::TupleLike===hash
        raise ICRb::DressError, "Invalid input `#{hash}` for #{self}"
      end

      coerced = Hash[heading.map{|name,infotype|
        value = hash[name] || hash[name.to_s] || hash[name.to_sym]
        value = infotype.dress(value) unless value.is_a?(infotype)
        [ name.to_sym, value ]
      }]
      new(coerced)
    end

    def self.undress(tuple)
      tuple.to_hash
    end

  end # class Tuple
end # module Alf
