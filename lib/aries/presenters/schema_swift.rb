module Aries

  module Presenters

    class SchemaSwift

      delegate :base_url, to: :original

      # @param schema [Aries::Schema]
      def initialize schema
        @schema = schema
      end

      # @return [Array<Aries::Presenters::ResourceSwift>]
      def resources
        original.resources.map{|r| ResourceSwift.new r }
      end

      private

      # @return [Aries::Schema]
      def original
        @schema
      end

    end

  end

end
