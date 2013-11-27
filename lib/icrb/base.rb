module ICRb
  class Base

    def initialize(target, name, infotype, invariant, options)
      @target = target
      @name = name
      @infotype = infotype
      @invariant = invariant
      @options = options
      install if options[:accessors] && (name != Unset)
    end
    attr_reader :target, :name, :infotype, :invariant, :options

    def self.build(target, name, infotype, invariant, options, &defn)
      Class.new(Base, &defn).new(target, name, infotype, invariant, options)
    end

    def _alpha(arg)
      if infotype_match?(arg)
        invariant_ok!(arg)
        alpha(arg)
      elsif infotype.respond_to?(:alpha)
        _alpha(infotype.alpha(arg))
      else
        raise AlphaError, "Invalid input `#{arg}` for #{infotype.name}"
      end
    end

    def _omega(inst)
      omega(inst)
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
        raise AlphaError, "Invalid input `#{arg}` for #{target.name}.#{name}"
      end
      arg
    end

  private

    def install
      install_loader
      install_dumper
    end

    def install_loader(ic = self)
      eigen_target.send(:define_method, name) do |arg|
        ic._alpha(arg)
      end
    end

    def install_dumper(ic = self)
      target.send(:define_method, :"to_#{name}") do
        ic._omega(self)
      end
    end

    def eigen_target
      class << target; self; end
    end

  end # class Base
end # module ICRb