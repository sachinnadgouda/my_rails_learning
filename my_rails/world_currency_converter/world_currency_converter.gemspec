# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'world_currency_converter/version'

Gem::Specification.new do |spec|
  spec.name          = "world_currency_converter"
  spec.version       = WorldCurrencyConverter::VERSION
  spec.authors       = ["Sachin Nadgouda"]
  spec.email         = ["sachinnadgouda+1@gmail.com"]
  spec.summary       = %q{Currency convertor}
  spec.description   = %q{Currency convertor}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "money",         "~> 6.7"
  spec.add_dependency "monetize",      "~> 1.4.0"
  spec.add_dependency "activesupport", ">= 3.0"
  spec.add_dependency "railties",      ">= 3.0"

  spec.add_development_dependency "rails",       ">= 3.0"
  spec.add_development_dependency "rspec-rails", "~> 3.0"
  #spec.add_development_dependency 'database_cleaner', ['>= 0.8.0', '< 1.4.0']
  #spec.add_development_dependency 'test-unit', '~> 3.0' if RUBY_VERSION >= '2.2'
end
