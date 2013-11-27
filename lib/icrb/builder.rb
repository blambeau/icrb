module ICRb
  class Builder

    # Default contract options
    DefaultOptions = {
      accessors: true
    }

    # Marker for default name
    Default = :default

    def initialize(adt, args, &dressers)
      @adt = adt
      @dressers = dressers
      @args, @invariant, @options = parse(args)
    end
    attr_reader :adt, :args, :invariant, :dressers, :options

    def self.ic(adt, args, &defn)
      new(adt, args, &defn).build
    end

    def build
      @contract = build_contract
      build_adt
      @contract
    end
    attr_reader :contract

  private

    def parse(args)
      name      = Default
      infotype  = nil
      invariant = nil
      options   = {}

      # parse arguments
      args.each do |arg|
        case arg
        when Symbol then name = arg
        when Proc   then invariant = arg
        when Class  then infotype = arg
        when Hash   then options = arg
        when Regexp then invariant = ->(iv){ arg =~ iv }
        end
      end

      # normalize options
      options = DefaultOptions.merge(options)
      options[:accessors] &= (name != Default)

      [[name, infotype], invariant, options]
    end

    ### Contract

    def build_contract
      dressers  = self.dressers
      invariant = self.invariant
      clazz = Class.new(Contract) do
        module_eval(&dressers)
        define_method(:valid?, &invariant) if invariant
      end
      clazz.new(adt, *args)
    end

    ### ADT

    def named?
      contract.name && (contract.name != Default)
    end

    def loader?
      named? && options[:accessors]
    end

    def dumper?
      named? && options[:accessors]
    end

    def build_adt
      install_loader if loader?
      install_dumper if dumper?
    end

    def install_loader
      contract = self.contract
      eigen_adt.send(:define_method, contract.name) do |arg|
        contract._dress(arg)
      end
    end

    def install_dumper
      contract = self.contract
      adt.send(:define_method, :"to_#{contract.name}") do
        contract._undress(self)
      end
    end

    def eigen_adt
      class << adt; self; end
    end

  end # class Builder
end # module ICRb
