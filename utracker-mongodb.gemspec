# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'utracker/mongodb/version'

Gem::Specification.new do |spec|
  spec.name          = "utracker-mongodb"
  spec.version       = Utracker::MongoDB::VERSION
  spec.authors       = ["Nicolas ZERMATI"]
  spec.email         = ["nicoolas25@gmail.com"]
  spec.summary       = %q{MongoDB backend for utracker.}
  spec.homepage      = "http://github.com/nicoolas25/micro-tracker"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "utracker"
  spec.add_dependency "bson_ext"
  spec.add_dependency "mongo"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "codeclimate-test-reporter"
end
