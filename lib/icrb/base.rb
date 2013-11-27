module ICRb
  class Base

    def initialize(target, name, datatype, invariant, options)
      @target = target
      @name = name
      @datatype = datatype
      @invariant = invariant
      @options = options
      install if options[:accessors] && (name != Unset)
    end
    attr_reader :target, :name, :datatype, :invariant, :options

    def self.build(target, name, datatype, invariant, options, &defn)
      Class.new(Base, &defn).new(target, name, datatype, invariant, options)
    end

    def _alpha(arg)
      if datatype_match?(arg)
        invariant_ok!(arg)
        alpha(arg)
      elsif datatype.respond_to?(:alpha)
        _alpha(datatype.alpha(arg))
      else
        raise AlphaError, "Invalid input `#{arg}` for #{datatype.name}"
      end
    end

    def _omega(inst)
      omega(inst)
    end

  private

    def datatype_match?(arg)
      datatype===arg
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