module Aries

  module Presenters

    class ParamSwift

      delegate :has_children?, to: :original

      # @param [Aries::Param]
      def initialize param
        @param = param
      end

      def name
        original.pretty_name.camelize(:lower)
      end

      def param_class
        type.param_class
      end

      def type
        ParamTypeSwift.new original.type
      end

      def params
        original.params.map{|v| ParamSwift.new v }
      end

      private

      # @return [Aries::Param]
      def original
        @param
      end

    end

  end

end
