# HttpHeaders::AcceptLanguage

[![Build Status: master](https://travis-ci.com/XPBytes/http_headers-accept_language.svg)](https://travis-ci.com/XPBytes/http_headers-accept)
[![Gem Version](https://badge.fury.io/rb/http_headers-accept_language.svg)](https://badge.fury.io/rb/http_headers-accept)
[![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT)

:nut_and_bolt: Utility to parse and sort the "Accept-Language" HTTP Header

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'http_headers-accept_language'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install http_headers-accept_language

## Usage

You can parse the "Accept-Language" header. As per the RFCs, you should really have one (delimited) value but the current 
implementation accepts an array of values.

```ruby
require 'http_headers/accept_language'

parsed = HttpHeaders::AcceptLanguage.new('nl-NL, nl, en-US; q=0.4, en; q=0.1')
parsed.first.region
# => 'NL' 
parsed.last.q
# => 0.1
 
 
parsed = HttpHeaders::AcceptLanguage.new([
  'eo; q=0.1', 
  'es-ES; foo=bar, es-MX; q=0.9'
])
parsed.first[:foo]
# => bar
parsed.last.to_s
# => 'eo; q=0.1'
parsed[1].locale
# => 'es-MX' 
```

Each parsed entry has the following methods:
- `locale`: the parsed locale
- `language`: the language part of the `locale`
- `region`: the region part of the `locale`
- `q`: the quality parameter as float, or 1.0
- `[](parameter)`: accessor for the parameter; throws if it does not exist
- `to_s`: encode back to an entry to be used in a `Accept-Language` header

## Related

- [HttpHeaders::Utils](https://github.com/XPBytes/http_headers-utils): :nut_and_bolt: Utility belt for the HttpHeader libraries
- [HttpHeaders::Accept](https://github.com/XPBytes/http_headers-accept): :nut_and_bolt: Utility to parse and sort the "Accept" HTTP Header
- [HttpHeaders::ContentType](https://github.com/XPBytes/http_headers-content_type): :nut_and_bolt: Utility to parse and sort the "Content-Type" HTTP Header
- [HttpHeaders::Link](https://github.com/XPBytes/http_headers-link): :nut_and_bolt: Utility to parse and sort the "Link" HTTP Header

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can
also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the
version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at [XPBytes/http_headers-accept](https://github.com/XPBytes/http_headers-accept).
