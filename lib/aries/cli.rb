module Aries

  class Cli < ::Thor

    option :output, aliases: "-o"
    option :name, aliases: "-n"
    option :url,  aliases: "-u"
    desc "generate SCHEMA_FILE_PATH", "generate api client from schem schema"
    def generate schema_file
      Aries::Generator.generate(schema_file, {}.tap { |opt|
        opt[:output_path] = options[:output] if options[:output]
        opt[:class_name]  = options[:name]   if options[:name]
        opt[:base_url]    = options[:url]    if options[:url]
      })
    end

  end

end
