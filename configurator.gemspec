# frozen_string_literal: true
require_relative 'lib/configurator/version'

Gem::Specification.new do |spec|
  spec.name          = 'configurator'
  spec.version       = Configurator::VERSION
  spec.authors       = ['wz', 'Robert Fletcher']
  spec.email         = ['wz0403@gmail.com', 'lobatifricha@gmail.com']

  spec.summary       = 'Configurator add configuration behavior to Class'
  spec.homepage      = 'https://github.com/mockdeep/configurator'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0'
  spec.add_dependency 'activesupport', '~> 4.2'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'guard', '~> 2.14'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.45.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.8.0'
  spec.add_development_dependency 'simplecov', '~> 0.12'
end
