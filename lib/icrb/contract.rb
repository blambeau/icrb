module ICRb
  class Contract

    def initialize(target, name, infotype)
      @target = target
      @name = name
      @infotype = infotype
    end
    attr_reader :target, :name, :infotype

    def _dress(infovalue)
      if infotype === infovalue
        dress valid!(infovalue)
      elsif infotype.respond_to?(:dress)
        _dress(infotype.dress(infovalue))
      else
        raise DressError, "Invalid input `#{infovalue}` for #{infotype.name}"
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
      unless valid?(infovalue)
        raise DressError, "Invalid input `#{infovalue}` for #{target.name}.#{name}"
      end
      infovalue
    end

  end # class Contract
end # module ICRb
require_relative 'contract/or'