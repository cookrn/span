# Span

[![Gem Version](https://badge.fury.io/rb/span.png)](http://badge.fury.io/rb/span)

Calculate the differences between two dates. A few notes:

* It is calendar-correct, meaning that it respects non-30-day months
* It currently only calculates the composite span, meaning that each
  quantity in the result hash contributes to the total span.
* No external dependencies except the standard library

## Installation

Add this line to your application's Gemfile:

    gem 'span'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install span

## Usage

`Span` ships with a single entry point for its API currently: `compute`.

```ruby
require 'span'
end_date = Date.parse '25/03/2013'
start_date = Date.parse '01/01/2012'
result = Span.compute end_date , start_date
puts result[ :year ].inspect  # => 1
puts result[ :month ].inspect # => 2
puts result[ :week ].inspect  # => 3
puts result[ :day ].inspect   # => 4
```

It returns a `Hash` that has four `Symbol` keys: `:year`, `:month`, `:week`,
and `:day`.

## TODOs

* Add more API options
* Better tests?
* Clean up code to make it easier to contribute

## Contributing

1. Fork it ( http://github.com/cookrn/span/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
