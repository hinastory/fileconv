lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fileconv/version"

Gem::Specification.new do |spec|
  spec.name          = "fileconv"
  spec.version       = Fileconv::VERSION
  spec.authors       = ["hinastory"]
  spec.email         = ["1696779+hinastory@users.noreply.github.com"]

  spec.summary       = %q{Extensible multi-file convertor. Simple text file, CSV file, JSON file, binary file and so on.}
  spec.description   = %q{Extensible multi-file convertor. Simple text file, CSV file, JSON file, binary file and so on.}
  spec.homepage      = "https://github.com/hinastory/fileconv"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hinastory/fileconv"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.3.0"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
end
