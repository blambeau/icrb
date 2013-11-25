module ICRb
  module DSL

    def ics
      @ics ||= Choice.new(self)
    end

    def ic(name, datatype, precondition = nil, &defn)
      ics[name] = ICRb::Base.build(self, name, datatype, precondition, &defn)
    end

    def alpha(arg)
      ics._alpha(arg)
    end

    def omega(inst, using = nil)
      ics._omega(inst, using)
    end

  end # module DSL
  include(DSL)
end # module ICRb