module ICRb
  class Builder

    # Default contract options
    DefaultOptions = {
      accessors: true
    }

    # Marker for default name
    Default = :default

    def initialize(datatype, args, &dressers)
      @datatype = datatype
      @dressers = dressers
      @args, @invariant, @options = parse(args)
    end
    attr_reader :datatype, :args, :invariant, :dressers, :options

    def self.ic(datatype, args, &defn)
      new(datatype, args, &defn).build
    end

    def build
      @contract = build_contract
      build_datatype
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
      clazz.new(datatype, *args)
    end

    ### Datatype

    def named?
      contract.name && (contract.name != Default)
    end

    def loader?
      named? && options[:accessors]
    end

    def dumper?
      named? && options[:accessors]
    end

    def build_datatype
      install_loader if loader?
      install_dumper if dumper?
    end

    def install_loader
      contract = self.contract
      eigen_datatype.send(:define_method, contract.name) do |arg|
        contract._dress(arg)
      end
    end

    def install_dumper
      contract = self.contract
      datatype.send(:define_method, :"to_#{contract.name}") do
        contract._undress(self)
      end
    end

    def eigen_datatype
      class << datatype; self; end
    end

  end # class Builder
end # module ICRb
