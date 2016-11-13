lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'configurator/version'

Gem::Specification.new do |spec|
  spec.name          = "configurator"
  spec.version       = Configurator::VERSION
  spec.authors       = ["wz", "Robert Fletcher"]
  spec.email         = ["wz0403@gmail.com", "lobatifricha@gmail.com"]

  spec.summary       = "Configurator add configuration behavior to Class"
  spec.homepage      = "https://github.com/mockdeep/configurator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9'

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
