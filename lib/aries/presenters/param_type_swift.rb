module Aries

  module Presenters

    class ParamTypeSwift

      # @param param_type [Aries::ParamType]
      def initialize param_type
        @param_type = param_type
      end

      def param_class
        case original.type
        when "any"     then "AnyObject"
        when "array"   then "[AnyObject]"
        when "boolean" then "Bool"
        when "integer" then "Int"
        when "number"  then "Double"
        when "object"  then "[String:AnyObject]"
        when "string"  then "String"
        else "AnyObject"
        end
      end

      def original
        @param_type
      end

    end

  end

end
