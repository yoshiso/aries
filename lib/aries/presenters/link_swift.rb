module Aries

  module Presenters

    class LinkSwift

      delegate :http_method, :href, :pretty_href, :encode, :has_params?, to: :original

      # @param link [Aries::Link]
      def initialize link
        @link = link
      end

      # @return [String]
      def method_name
        original.method_name.camelcase
      end

      [:required_params, :optional_params, :params,
                         :prop_params, :url_params].each do |m|
        define_method(m) do
          original.send(m).map{|v| ParamSwift.new v }
        end
      end

      # @return [String] params string for template
      def params_for_method
        if params.size > 0
          (required_params.map{|v| "#{v.name}: #{v.param_class}" } +
            optional_params.map{|v| "#{v.name}: #{v.param_class}? = nil"}).join(', ')
        else
          ""
        end
      end

      # @return [String] param keys string for template
      def params_keys
        if params.size > 0
          params.map{|v| v.name}.join(',')
        else
          ""
        end
      end

      private

      def original
        @link
      end

    end

  end

end
