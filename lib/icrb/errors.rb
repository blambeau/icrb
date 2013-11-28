module ICRb

  Error = Class.new(StandardError)

  class DressError < Error

    def initialize(msg, cause = nil)
      super(msg)
      @cause = cause
    end
    attr_reader :cause

  end # class DressError

  class UndressError < Error
  end

end
