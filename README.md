# Aries

Aries is a iOS(Swift), Andorid(not yet, but future) HTTP client generator for APIs represented with JSON Schema

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'aries'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install aries

## Usage

### Generate a client

Aries generates an HTTP client from a JSON schema that describes your API. Look at prmd for tooling to help write a JSON schema. When you have a JSON schema prepared you can generate a client for your API

    $ bin/aries generate json-schema.json

### Custom Configuration

Aries can setup costom config for api client class name, base url, output path.

    $ bin/aries generate json-schema.json --name MyApi \
                                          --url http://api.myapp.com \
                                          --output /path/to/dir

## Swift(ios)

Dependent on [SwiftTask](https://github.com/ReactKit/SwiftTask), [Alamofire](https://github.com/Alamofire/Alamofire), [URITemplate](https://github.com/kylef/URITemplate.swift).
Aries api client should be used with these libraries.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/aries/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
