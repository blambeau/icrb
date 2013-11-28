module ICRb
  class Contract
    class Or

      def initialize(datatype, alternatives = {})
        @datatype = datatype
        @alternatives = alternatives
      end
      attr_reader :datatype, :alternatives

      def []=(name, ic)
        alternatives[name] = ic
      end

      def empty?
        alternatives.empty?
      end

      def infotype(using = nil)
        contract!(using).infotype
      end

      def _to_json(arg, *args, &bl)
        arg.class.undress(arg).to_json(*args, &bl)
      end

      def _to_yaml(arg, *args, &bl)
        arg.class.undress(arg).to_yaml(*args, &bl)
      end

      def _dress(arg)
        not_empty!
        error = nil
        alternatives.each_pair do |name, ic|
          begin
            return ic._dress(arg)
          rescue DressError => ex
            error = ex
          end
        end
        raise(error)
      end

      def _undress(inst, using = nil)
        if empty? && (sc = datatype.superclass)
          datatype.superclass.undress(inst, using)
        else
          contract!(using)._undress(inst)
        end
      end

    private

      def contract!(using = nil)
        using ? has_contract!(using) : default_contract!
      end

      def not_empty!
        raise DressError, "No information contract on #{datatype.name}" if empty?
      end

      def has_contract!(name)
        unless ic = alternatives[name]
          alts = alternatives.keys.join(',')
          msg  = "No information contract `#{name}` (got: #{alts})"
          raise UndressError, msg
        end
        ic
      end

      def default_contract!
        not_empty!
        alternatives.values.first
      end

    end # class Or
  end # class Contract
end # module ICRb
