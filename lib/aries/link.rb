module Aries
  class Link

    URL_REGEXP = /\{\(#([%\/a-zA-Z0-9_-]*)\)\}/

    attr_reader :parent

    # @param link [JsonSchema::Schema::Link]
    def initialize link, parent = nil
      @link = link
      @parent = parent
    end

    # @return [Array<Aries::Param>] Required request parameter
    def required_params
      if @link.schema && @link.schema.required && params
        params.select{|param| @link.schema.required.include? param.name } + url_params
      else
        url_params
      end
    end

    # @return [Array<Aries::Param>] Optional requrest parameter
    def optional_params
      params - required_params
    end

    # @return [Array<Aries::Param>]
    def params
      (prop_params + url_params).uniq
    end

    # @return [Array<Aries::Param]
    def prop_params
      @prop_params ||= if @link.schema && @link.schema.properties
                         @link.schema.properties.map do |name, definition|
                           Param.new name, definition, self, type: :prop
                         end
                       else
                         []
                       end
    end

    # @return [Array<Aries::Param>]
    def url_params
      @url_params ||= href.scan(URL_REGEXP).flatten.map do |param|
        Param.new param.split('/').last, root_schema.property_by(param), self, type: :url
      end
    end

    # @return [TrueClass, FalseClass]
    def has_params?
      params.size > 0
    end

    # @return [String] api client's request method name
    # @example
    #   method_name #=> "list"
    def method_name
      title.split.join('_').underscore
    end

    # @return [String] http request method
    def http_method
      @link.method.to_s.upcase
    end

    # @return [String] requrest encode type URL encode or JSON encode used in client
    def encode
      case http_method
      when "GET"
        "URL"
      else
        "JSON"
      end
    end

    # @return [String] convert uri template to {resource_name}_{action_name} template
    def pretty_href
      href.gsub(URL_REGEXP){|n| "{" + n.scan(/definitions\/([a-zA-Z0-9\-\_]+)/)
                                       .map{|v| v[0].split('-').join('_') }.join('_').camelize(:lower) + "}"  }
    end

    # @return [String] url decoded href string
    def href
      URI.decode @link.href
    end

    # @return [String]
    def title
      @link.title
    end

    def inspect
      return "#<Link title=#{title}>"
    end


    # @return [Aries::Schema] Root schema of link
    def root_schema
      @parent.respond_to?(:parent) ? @parent.root_schema : @parent
    end

  end
end
