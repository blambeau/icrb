module ICRb
  module Infotype

    def self.new(supertype = Object, constraints = [])
      clazz = Class.new(supertype).extend(Infotype)
      constraints.each do |c|
        clazz.such_that(c)
      end
      clazz
    end

    def self.[](supertype)
      new(supertype)
    end

    def constraints
      @constraints ||= []
    end

    def such_that(predicate = nil, &bl)
      constraints << (predicate || bl)
      self
    end

    def ===(value)
      superclass.===(value) && constraints.all?{|c| c === value }
    end

  end # class Infotype
end # module ICRb
