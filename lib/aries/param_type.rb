module Aries

  class ParamType

    ALLOWED_TYPES = %w{any array boolean integer number null object string}

    def initialize type, parent = nil
      @type = type
      @parent = parent
    end

    def type
      @type
    end

  end

end
