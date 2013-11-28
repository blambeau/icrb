module ICRb
  class Infotype

    def initialize(supertype = Object, constraints = [])
      @supertype   = supertype
      @constraints = constraints
    end
    attr_reader :supertype, :constraints

    def self.[](supertype = Object)
      new(supertype)
    end

    def such_that(predicate = nil, &bl)
      constraints << (predicate || bl)
      self
    end

    def ===(value)
      return false unless supertype === value
      constraints.all?{|c| c === value }
    end

    # supertype delegation

    def new(*args, &bl)
      supertype.new(*args, &bl)
    end

    def heading(*args, &bl)
      supertype.heading(*args, &bl)
    end

    def dress(*args, &bl)
      supertype.dress(*args, &bl)
    end

    def undress(*args, &bl)
      supertype.undress(*args, &bl)
    end

  end # class Infotype
end # module ICRb
