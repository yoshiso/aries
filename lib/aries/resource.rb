module Aries

  class Resource

    attr_reader :parent

    #
    # @param [String] name of schema
    # @param [JsonSchema::Schema] json schema object
    def initialize name, schema, parent = nil
      @name   = name
      @schema = schema
      @parent = parent
    end

    # @return String name of resource
    def name
      @name.split('-').join("_")
    end

    # @return [Array<Aries::Link>] links owned by resource
    def links
      @links ||= @schema.links.map do |link|
        Link.new(link, self)
      end
    end

    # @return [Aries::Schema] Root schema of resource
    def root_schema
      @parent.respond_to?(:parent) ? @parent.root_schema : @parent
    end

  end

end
