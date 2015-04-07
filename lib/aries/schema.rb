module Aries

  class Schema

    #
    # @param Hash [JSON] Json Schema Object
    # @raise [JsonSchema::SchemaError]
    #
    def initialize schema
      @schema = ::JsonSchema.parse!(schema).tap(&:expand_references!)
    end

    # Resources of json schema
    # @param [Array<Aries::Resource>]
    def resources
      @resources ||= @schema.properties.map do |name, schema|
        Resource.new name, schema, self
      end
    end

    # Find base url of api
    # @return [String] url
    # @raise [Aries::BaseUrlNotFound]
    def base_url
      root_link.try(:href) or raise BaseUrlNotFound
    end

    # Finds link that has "self" rel to resolve API base URL
    # @return [JsonSchema::Schema::Link, nil]
    def root_link
      @schema.links.find do |link|
        link.rel == "self"
      end
    end

    # @param href [String]
    # @return [JsonSchema::Schema]
    # @example
    #   property_by "#/definitions/apps/definitions/identiry" #=> JsonSchema::Schema
    def property_by href
      accessor = href.gsub(/([a-zA-Z0-9\-\_]+)/).to_a
      result = @schema
      accessor.each_with_index do |a, i|
        result = (i % 2) == 0 ? result.send(a.to_sym) : result[a]
      end
      result
    end

    def inspect
      "#<Aries::Schema base_url=#{base_url}>"
    end

  end
  class BaseUrlNotFound < Error
  end
end
