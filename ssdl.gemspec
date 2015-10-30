# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ssdl/version'

Gem::Specification.new do |spec|
  spec.name          = 'ssdl'
  spec.executables   = ['ssdl']

  spec.version       = Ssdl::VERSION
  spec.authors       = ['tigberd']
  spec.email         = ['tigberd@gmail.com']
  spec.summary       = 'SlideShare slide images downloader'
  spec.homepage      = 'https://github.com/tigberd/ssdl'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.license       = 'MIT'

  spec.homepage      = 'https://github.com/tigberd/ssdl'

  spec.add_runtime_dependency 'nokogiri', '~> 1.6'
  spec.add_runtime_dependency 'prawn', '~> 1.3'
  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
