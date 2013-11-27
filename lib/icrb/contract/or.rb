module ICRb
  class Contract
    class Or

      def initialize(target, alternatives = {})
        @target = target
        @alternatives = alternatives
      end
      attr_reader :target, :alternatives

      def []=(name, ic)
        alternatives[name] = ic
      end

      def empty?
        alternatives.empty?
      end

      def infotype(using = nil)
        not_empty!
        return infotype(alternatives.keys.first) unless using
        has_contract!(using).infotype
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
        if empty? && (sc = target.superclass)
          target.superclass.undress(inst, using)
        else
          not_empty!
          return _undress(inst, alternatives.keys.first) unless using
          has_contract!(using)._undress(inst)
        end
      end

    private

      def not_empty!
        raise DressError, "No information contract on #{target.name}" if empty?
      end

      def has_contract!(name)
        ic = alternatives[name]
        raise UndressError, "No information contract `#{name}` (got: #{alternatives.keys.join(',')})" unless ic
        ic
      end

    end # class Or
  end # class Contract
end # module ICRb
