# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'quanto/version'

Gem::Specification.new do |spec|
  spec.name          = "quanto-ruby"
  spec.version       = Quanto::VERSION
  spec.authors       = ["Rasmus Rygaard"]
  spec.email         = ["rasmus@rasmusrygaard.com"]
  spec.description   = %q{This gem acts as an API wrapper for the quanto quantified self application.}
  spec.summary       = %q{a Ruby API for quanto}
  spec.homepage      = "https://github.com/rasmusrygaard/quanto-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "oauth2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
