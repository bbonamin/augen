# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'augen/version'

Gem::Specification.new do |spec|
  spec.name          = 'augen'
  spec.version       = Augen::VERSION
  spec.authors       = ['Bruno Bonamin']
  spec.email         = ['bruno@bonamin.org']

  spec.summary       = 'Augen calculates scores for glider flights'
  spec.description   = 'Given a glider racing task , a set of scoring rules ' \
                       'and IGC file/s, Augen can calculate points for glider '\
                       'flights, similar to SeeYou and OLC.'
  spec.homepage      = 'https://github.com/bbonamin/augen'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'

  spec.add_development_dependency 'guard'
  spec.add_development_dependency 'guard-rubocop'
  spec.add_development_dependency 'guard-rspec'
end
