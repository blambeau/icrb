module ICRb
  class Builder

    # The predicate that accepts all values
    All = ->(arg){ true }

    # Default contract options
    DefaultOptions = {
      accessors: true
    }

    # Marker for default name
    Default = :default

    def initialize(adt, args, &dressers)
      @adt = adt
      @dressers = dressers
      @args, @options = parse(args)
    end
    attr_reader :adt, :options, :args, :dressers

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

      # normalize options
      options = DefaultOptions.merge(options)
      options[:accessors] &= (name != Default)

      [[name, infotype, invariant], options]
    end

    ### Contract

    def build_contract
      contract = Class.new(Contract, &dressers).new(adt, *args)
      contract
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
