module Aries

  module Presenters

    class ResourceSwift

      # @param resource [Aries::Resource]
      def initialize resource
        @resource = resource
      end

      def name
        original.name.camelcase
      end

      # @return [Array<Aries::Presenters::LinkSwift>]
      def links
        original.links.map{|li| LinkSwift.new li }
      end

      private

      # @return [Aries::Resource]
      def original
        @resource
      end

    end

  end

end
