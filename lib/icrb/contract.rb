module ICRb
  class Contract

    def initialize(name, datatype, infotype)
      @name = name
      @datatype = datatype
      @infotype = infotype
    end
    attr_reader :name, :datatype, :infotype

    def _dress(infovalue)
      if infotype === infovalue
        dress valid!(infovalue)
      elsif infotype.respond_to?(:dress)
        _dress(_subdress(infovalue))
      else
        invalid_error!(infovalue)
      end
    end

    def _undress(datatype)
      undress(datatype)
    end

  private

    def _subdress(infovalue)
      infotype.dress(infovalue)
    rescue DressError => ex
      invalid_error!(infovalue, ex)
    end

    def valid!(infovalue)
      invalid_error!(infovalue) unless infotype === infovalue
      infovalue
    end

    def invalid_error!(infovalue, cause = nil)
      msg = "Invalid input `#{infovalue}` for #{datatype.name}.#{name}"
      raise DressError.new(msg, cause)
    end

  end # class Contract
end # module ICRb
require_relative 'contract/or'