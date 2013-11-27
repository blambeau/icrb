module ICRb
  module ADT

    module ClassMethods

      def ics
        @ics ||= Choice.new(self)
      end

      def ic(*args, &defn)
        name      = Unset
        infotype  = nil
        invariant = All
        options   = {}

        # parse arguments
        args.each do |arg|
          case arg
          when Symbol then name = arg
          when Proc   then invariant = arg
          when Class  then infotype = arg
          when Hash   then options = arg
          when Regexp then invariant = arg
          end
        end

        # normalize
        options = DefaultOptions.merge(options)
        options[:accessors] &= (name != Unset)

        # build
        ics[name] = Contract.build(self, name, infotype, invariant, options, &defn)
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

    def undress(using = nil)
      self.class.undress(self, using)
    end

    def ==(other)
      (other.class == self.class) && (other.undress == self.undress)
    end
    alias :eql? :==

    def hash
      undress.hash
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