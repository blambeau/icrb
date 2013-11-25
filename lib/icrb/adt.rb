module ICRb
  module ADT

    module ClassMethods

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

    end # module ClassMethods

    def self.included(clazz)
      clazz.extend(ClassMethods)
    end

    def omega(using = nil)
      self.class.omega(self, using)
    end

    def ==(other)
      (other.class == self.class) && (other.omega == self.omega)
    end
    alias :eql? :==

    def hash
      omega.hash
    end

    def to_json(*args, &bl)
      require 'json'
      self.class.ics._to_json(self, *args, &bl)
    end

    def to_yaml(*args, &bl)
      require 'yaml'
      self.class.ics._to_yaml(self, *args, &bl)
    end

  end # module ADT
end # module ICRb