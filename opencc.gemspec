require_relative 'lib/opencc/version'

Gem::Specification.new do |spec|
  spec.name          = "opencc-rb"
  spec.version       = OpenCC::VERSION
  spec.authors       = ["zsj"]
  spec.email         = ["lekyzsj@gmail.com"]

  spec.summary       = %q{This gem is for conversions between Traditional Chinese, Simplified Chinese and Japanese Kanji (Shinjitai).}
  spec.description   = %q{This gem is for conversions between Traditional Chinese, Simplified Chinese and Japanese Kanji (Shinjitai). It supports character-level and phrase-level conversion, character variant conversion and regional idioms among Mainland China, Taiwan and Hong Kong.}
  spec.homepage      = "https://github.com/songjiz/opencc-rb"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.extensions    = ["ext/opencc/extconf.rb"]
end
