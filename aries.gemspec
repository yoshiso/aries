# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'aries/version'

Gem::Specification.new do |spec|
  spec.name          = "aries"
  spec.version       = Aries::VERSION
  spec.authors       = ["yss44"]
  spec.email         = ["nya060@gmail.com"]

  spec.summary       = %q{Aries is a iOS(Swift), Android(java,not yet) API Client generator represented with JSON Schema}
  spec.description   = %q{Aries is a iOS(Swift), Andorid(not yet, but future) HTTP client generator for APIs represented with JSON Schema}
  spec.homepage      = "https://github.com/yss44/aries"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "addressable"
  spec.add_dependency "thor"
  spec.add_dependency "activesupport"
  spec.add_dependency "json_schema"
  spec.add_dependency "erubis"
  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rack-json_schema"
  spec.add_development_dependency "rspec", "~> 3.0"
end
