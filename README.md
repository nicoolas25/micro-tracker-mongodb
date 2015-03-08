# Micro-tracker MongoDB backend

[![Build Status](https://travis-ci.org/nicoolas25/micro-tracker-mongodb.svg)](https://travis-ci.org/nicoolas25/micro-tracker-mongodb)
[![Code Climate](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb/badges/gpa.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb)
[![Test Coverage](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb/badges/coverage.svg)](https://codeclimate.com/github/nicoolas25/micro-tracker-mongodb)
[![Gem Version](https://badge.fury.io/rb/utracker-mongodb.svg)](http://badge.fury.io/rb/utracker-mongodb)

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

  # Set the log to the MongoDB instance at the MONGODB_URI env variable.
  # If no MONGODB_URI can be found, it will look MongoDB on localhost:27017.
  config[:logger] = Utracker::MongoDB::Logger.new(database_name: 'utracker')

  # ...
end
```

There is some options available when you're using the logger:

* `database_name` allow you to choose the database you want to use, default to `utracker`
* `collection_name` allow you to choose the collection you want to use, default to `entries`

[utracker]: https://github.com/nicoolas25/micro-tracker
