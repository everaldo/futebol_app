# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'futebol_app/version'

Gem::Specification.new do |spec|
  spec.name          = "futebol_app"
  spec.version       = FutebolApp::VERSION
  spec.authors       = ["Everaldo Gomes"]
  spec.email         = ["everaldo.gomes@gmail.com"]
  spec.description   = %q{FutebolApp: Manage Football Leagues}
  spec.summary       = %q{FutebolApp}
  spec.homepage      = "http://www.github.com/everaldo/futebol_app"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
