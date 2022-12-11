# frozen_string_literal: true

require_relative 'lib/hexlet_code/version'

Gem::Specification.new do |spec|
  spec.name          = 'hexlet_code'
  spec.version       = HexletCode::VERSION
  spec.authors       = ['Ruslan Knyazev']
  spec.email         = ['agrry@yandex.ru']

  spec.summary       = 'Form generator'
  spec.description   = 'Simple form generator.'
  spec.homepage      = 'https://github.com/orevenat/rails-project-lvl1'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.0.0')

  # spec.metadata["allowed_push_host"] = "http://mygemserver.com"

  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/orevenat/rails-project-lvl1'
  spec.metadata['changelog_uri'] = 'https://github.com/orevenat/rails-project-lvl1/blob/master/README.md'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  # rubocop:disable Layout/SpaceAroundOperators
  # rubocop:disable  Layout/ExtraSpacing
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  # rubocop:enable  Layout/ExtraSpacing
  # rubocop:enable Layout/SpaceAroundOperators
end
