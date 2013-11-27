class Integer
  extend ICRb::ADT::ClassMethods

  ic :literal, String, ->(s){ s =~ /^-?\d+$/ }, accessors: false do

    def alpha(s)
      Integer(s)
    end

    def omega(int)
      int.to_s
    end

  end # ic :literal

end # class Integer
