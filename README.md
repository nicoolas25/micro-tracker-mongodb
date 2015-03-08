# Micro-tracker MongoDB backend

This is a MongoDB backend for the [utracker][utracker] gem.

## Installation

Add `utracker-mongodb` in your Gemfile. It will add the dependency to the
`utracker` gem itself.

## Usage

``` ruby
require 'utracker'
require 'utracker/mongodb'

Utracker.configure do |config|
  # ...

  # Set the log to the MongoDB instance at the MONGO_URL env variable.
  config[:logger] = Utracker::MongoDB::Logger.new(ENV['MONGO_URL'])

  # ...
end
```

[utracker]: https://github.com/nicoolas25/micro-tracker
