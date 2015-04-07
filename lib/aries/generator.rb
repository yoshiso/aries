module Aries

  class Generator

    def self.generate schema_path, options
      new(schema_path, options).exec
    end

    #
    # @param file_path [String] json schema file path
    #
    def initialize schema_path, options ={}
      @schema_path = schema_path
      @output_path = options[:output_path] || Dir.pwd
      @class_name  = options[:class_name]  || "AriesApi"
      @language    = options[:language]     || "swift"
      @base_url    = options[:base_url]
    end

    # @return [Aries::Presenters::SchemaSwift]
    def schema
      case @language
      when "swift"
        Aries::Presenters::SchemaSwift.new original_schema
      end
    end

    # @return [Aries::Schema]
    def original_schema
      Schema.new JSON.parse(File.read(@schema_path))
    end

    # @return [String]
    def class_name
      @class_name.camelcase
    end

    # @return [String]
    def output_path
      @output_path
    end

    # @return [String]
    def extension
      case @language
      when "swift" then "swift"
      when "java" then "java"
      end
     end

    # @return [String]
    def file_name
      class_name + "." + extension
    end

    # @return [String]
    def base_url
      @base_url || schema.base_url
    end

    # @return [Array<Aries::Presenters::ResourceSwift>]
    def resources
      schema.resources
    end

    # @return [String]
    def template_path
      File.expand_path("../templates/client.#{@language}.erb", __FILE__)
    end

    # @return [String]
    def file_path
      output_path + "/" + file_name
    end

    # @return [ERB]
    def template
      Erubis::Eruby.new File.read(template_path), trim: true
    end

    def timestamp
      Time.now.strftime('%Y/%m/%d')
    end

    # @return [TrueClass, FalseClass]
    def exec
      return puts "File already exists" if File.exist?(file_path)
      File.write file_path, template.result(binding)
      true
    end

  end

end
