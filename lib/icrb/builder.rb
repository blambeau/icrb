module ICRb
  class Builder

    # Default contract options
    DefaultOptions = {
      internal: false,
      accessors: true
    }

    # Marker for default name
    Default = :default

    def initialize(name, datatype, infotype, options, dressers)
      @name = name
      @datatype = datatype
      @infotype = infotype
      @options  = options
      @dressers = dressers
    end
    attr_reader :name, :datatype, :infotype, :options, :dressers

    def self.ic(args, &dressers)
      name        = Default
      datatype    = nil
      supertype   = Object
      constraints = []
      options     = {}

      # parse arguments
      args.each do |arg|
        case arg
        when Symbol then name = arg
        when Class  then datatype.nil? ? (datatype = arg) : (supertype = arg)
        when Hash   then options = arg
        else
          constraints << arg
        end
      end

      # normalize options
      options = DefaultOptions.merge(options)
      options[:accessors] &= (name != Default)

      # normalize infotype
      infotype = constraints.empty? ? supertype : Infotype.new(supertype, constraints)

      # build now
      new(name, datatype, infotype, options, dressers).build
    end

    def build
      build_contract_class
      build_contract
      build_datatype
      return contract
    end
    attr_reader :contract, :contract_class

  private

    def internal?
      options[:internal]
    end

    ### Contract class

    def build_contract_class
      @contract_class = Class.new(Contract)
      install_internal_dressing if internal?
      install_dressers          if dressers
    end

    def install_internal_dressing
      contract_class.module_eval do
        def dress(internal)
          datatype.new(internal)
        end
        def undress(adt)
          adt.send(:internal)
        end
      end
    end

    def install_dressers
      contract_class.module_eval(&dressers) if dressers
    end

    ### Contract

    def build_contract
      @contract = contract_class.new(name, datatype, infotype)
    end

    ### Datatype

    def build_datatype
      install_loader   if loader?
      install_dumper   if dumper?
      install_internal if internal?
    end

    def named?
      contract.name && (contract.name != Default)
    end

    def loader?
      named? && options[:accessors]
    end

    def dumper?
      named? && options[:accessors]
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

    def install_internal
      datatype.module_eval{ include(Internal) }
    end

    def eigen_datatype
      class << datatype; self; end
    end

    module Internal

      def initialize(internal)
        @internal = internal
      end
      attr_reader :internal

      def ==(other)
        (other.class == self.class) && (other.internal == self.internal)
      end
      alias :eql? :==

      def hash
        internal.hash
      end

      protected :internal
    end # module Internal

  end # class Builder
end # module ICRb
