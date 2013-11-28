module ICRb
  class Contract

    def initialize(datatype, name, infotype)
      @datatype = datatype
      @name = name
      @infotype = infotype
    end
    attr_reader :datatype, :name, :infotype

    def _dress(infovalue)
      if infotype === infovalue
        dress valid!(infovalue)
      elsif infotype.respond_to?(:dress)
        _dress(infotype.dress(infovalue))
      else
        invalid_error!(infovalue)
      end
    end

    def _undress(datatype)
      undress(datatype)
    end

    def valid?(infovalue)
      true
    end

  private

    def valid!(infovalue)
      invalid_error!(infovalue) unless (infotype===infovalue) && valid?(infovalue)
      infovalue
    end

    def invalid_error!(infovalue)
      raise DressError, "Invalid input `#{infovalue}` for #{datatype.name}.#{name}"
    end

  end # class Contract
end # module ICRb
require_relative 'contract/or'