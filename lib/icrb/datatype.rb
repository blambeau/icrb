module ICRb
  module Datatype

    module ClassMethods

      def ics
        @ics ||= Contract::Or.new(self)
      end

      def ic(*args, &defn)
        contract = Builder.ic(self, args, &defn)
        ics[contract.name] = contract
      end

      def dress(arg)
        ics._dress(arg)
      end

      def undress(inst, using = nil)
        ics._undress(inst, using)
      end

    end # module ClassMethods

    def self.included(clazz)
      clazz.extend(ClassMethods)
    end

    def ==(other)
      return false unless other.class == self.class
      self.class.undress(other) == self.class.undress(self)
    end
    alias :eql? :==

    def hash
      self.class.undress(self).hash
    end

    def to_json(*args, &bl)
      require 'json'
      self.class.ics._to_json(self, *args, &bl)
    end

    def to_yaml(*args, &bl)
      require 'yaml'
      self.class.ics._to_yaml(self, *args, &bl)
    end

  end # module Datatype
end # module ICRb
