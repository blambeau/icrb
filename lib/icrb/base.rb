module ICRb
  class Base

    def initialize(target, name, datatype, precondition, options)
      @target = target
      @name = name
      @datatype = datatype
      @precondition = precondition
      @options = options
      install if options[:accessors] && (name != Unset)
    end
    attr_reader :target, :name, :datatype, :precondition, :options

    def self.build(target, name, datatype, precondition, options, &defn)
      Class.new(Base, &defn).new(target, name, datatype, precondition, options)
    end

    def datatype_match?(arg)
      datatype===arg
    end

    def precondition_ok?(arg)
      precondition===arg
    end

    def precondition_ok!(arg)
      unless precondition_ok?(arg)
        raise AlphaError, "Invalid input `#{arg}` for #{target.name}.#{name}"
      end
      arg
    end

    def _alpha(arg)
      if datatype_match?(arg)
        precondition_ok!(arg)
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