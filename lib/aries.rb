require "active_support/core_ext/object/try"
require "active_support/core_ext/string/inflections"
require "active_support/core_ext/module/delegation"
require 'json'
require 'json_schema'
require 'erubis'
require 'thor'
require 'addressable/template'

require "aries/version"
require "aries/error"
require "aries/schema"
require "aries/resource"
require "aries/link"
require "aries/param"
require "aries/param_type"
require "aries/generator"
require "aries/cli"

require "aries/presenters/schema_swift"
require "aries/presenters/resource_swift"
require "aries/presenters/link_swift"
require "aries/presenters/param_swift"
require "aries/presenters/param_type_swift"

module Aries

end
