# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'korean_foreign_spell_dictionary/version'

Gem::Specification.new do |spec|
  spec.name          = 'korean_foreign_spell_dictionary'
  spec.version       = KoreanForeignSpellDictionary::VERSION
  spec.authors       = ['Shim Won']
  spec.email         = ['marocchino@gmail.com']

  spec.summary       = '외래어 표기법 사전'
  spec.description   = '추출해둔 데이터를 사용하실 수 있습니다.'
  spec.homepage      = 'https://github.com/marocchino/korean_foreign_spell_dictionary'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'nokogiri'
end
