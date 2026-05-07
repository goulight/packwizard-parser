# frozen_string_literal: true

require_relative 'lib/packwizard_parser/version'

Gem::Specification.new do |spec|
  spec.name          = 'packwizard-parser'
  spec.version       = PackwizardParser::VERSION
  spec.authors       = ['Aross AB / Goulight']
  spec.email         = ['hello@goulight.com']

  spec.summary       = 'Parser for PackWizard lists'
  spec.description   = 'Parse PackWizard to extract list data including categories, items, weights, and metadata'
  spec.homepage      = 'https://github.com/goulight/packwizard-parser'
  spec.license       = 'MIT'

  spec.metadata = {
    'source_code_uri' => 'https://github.com/goulight/packwizard-parser'
  }

  spec.required_ruby_version = '>= 3.0'

  spec.files         = Dir['lib/**/*', 'spec/**/*', '*.md', '*.gemspec']
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty', '~> 0.24'

  spec.add_development_dependency 'rspec', '~> 3.13'
end
