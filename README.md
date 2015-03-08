# Micro-tracker MongoDB backend

[![Build Status](https://travis-ci.org/nicoolas25/micro-tracker-mongodb.svg)](https://travis-ci.org/nicoolas25/micro-tracker-mongodb)
[![Code Climate](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb/badges/gpa.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb)
[![Test Coverage](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb/badges/coverage.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb)

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
