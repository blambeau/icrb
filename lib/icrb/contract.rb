module ICRb
  class Contract

    def initialize(target, name, infotype, invariant)
      @target = target
      @name = name
      @infotype = infotype
      @invariant = invariant
    end
    attr_reader :target, :name, :infotype, :invariant

    def self.build(target, name, infotype, invariant, &defn)
      Class.new(self, &defn).new(target, name, infotype, invariant)
    end

    def _dress(arg)
      if infotype_match?(arg)
        invariant_ok!(arg)
        dress(arg)
      elsif infotype.respond_to?(:dress)
        _dress(infotype.dress(arg))
      else
        raise DressError, "Invalid input `#{arg}` for #{infotype.name}"
      end
    end

    def _undress(inst)
      undress(inst)
    end

  private

    def infotype_match?(arg)
      infotype===arg
    end

    def invariant_ok?(arg)
      invariant===arg
    end

    def invariant_ok!(arg)
      unless invariant_ok?(arg)
        raise DressError, "Invalid input `#{arg}` for #{target.name}.#{name}"
      end
      arg
    end

  end # class Contract
end # module ICRb
require_relative 'contract/or'