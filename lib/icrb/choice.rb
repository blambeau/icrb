module ICRb
  class Choice

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
      arg.class.omega(arg).to_json(*args, &bl)
    end

    def _to_yaml(arg, *args, &bl)
      arg.class.omega(arg).to_yaml(*args, &bl)
    end

    def _alpha(arg)
      not_empty!
      error = nil
      alternatives.each_pair do |name, ic|
        begin
          return ic._alpha(arg)
        rescue AlphaError => ex
          error = ex
        end
      end
      raise(error)
    end

    def _omega(inst, using = nil)
      if empty? && (sc = target.superclass)
        target.superclass.omega(inst, using)
      else
        not_empty!
        return _omega(inst, alternatives.keys.first) unless using
        has_contract!(using)._omega(inst)
      end
    end

  private

    def not_empty!
      raise AlphaError, "No information contract on #{target.name}" if empty?
    end

    def has_contract!(name)
      ic = alternatives[name]
      raise OmegaError, "No information contract `#{name}` (got: #{alternatives.keys.join(',')})" unless ic
      ic
    end

  end # class Choice
end # module ICRb
