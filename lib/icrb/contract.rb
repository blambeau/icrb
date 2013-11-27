module ICRb
  class Contract

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
      Class.new(self, &defn).new(target, name, infotype, invariant, options)
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

  private

    def install
      install_loader
      install_dumper
    end

    def install_loader(ic = self)
      eigen_target.send(:define_method, name) do |arg|
        ic._dress(arg)
      end
    end

    def install_dumper(ic = self)
      target.send(:define_method, :"to_#{name}") do
        ic._undress(self)
      end
    end

    def eigen_target
      class << target; self; end
    end

  end # class Contract
end # module ICRb
require_relative 'contract/or'