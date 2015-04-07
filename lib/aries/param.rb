module Aries

  class Param

    attr_reader :parent

    def initialize name, definition, parent = nil, options = {}
      @name = name
      @definition = definition
      @parent = parent
      @param_type = options[:type]
    end

    def name
      @name
    end

    # @return [String] name of param
    def pretty_name
      if @param_type == :url && has_resource?
        "#{@parent.parent.name}_#{name}"
      else
        name
      end
    end

    # @return [Array<Aries::Param>]
    def params
      @definition.properties.map do |name, definition|
        Aries::Param.new name, definition, self, type: @param_type
      end
    end

    # @return [TrueClass, FalseClass] whether contains null or not
    def optional?
      @definition.type.detect{|type| type == "null" } != nil
    end

    # @return [TrueClass, FalseClass] whether contains child parameters
    def has_children?
      @definition.type.detect{|type| type == "object" } != nil
    end

    # @return [Array<Aries::Type>]
    def type
      Aries::ParamType.new @definition.type.detect{|type| type != "null"}, self
    end

    def inspect
      return "#<Aries::Param name=#{name} >"
    end

    private

    def param_tree
      trees = [self]
      pr = parent
      while pr.kind_of?(Param)
        trees.unshift pr
        pr = pr.parent
      end
      trees
    end

    def has_resource?
      if parent.kind_of?(Param)
        parent.has_resource?
      else
        parent.respond_to?(:parent) && parent.parent.kind_of?(Resource)
      end
    end

  end

end
