lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fileconv/version"

Gem::Specification.new do |spec|
  spec.name          = "fileconv"
  spec.version       = Fileconv::VERSION
  spec.authors       = ["hinastory"]
  spec.email         = ["1696779+hinastory@users.noreply.github.com"]

  spec.summary       = %q{Extensible multi-file convertor.}
  spec.description   = %q{Extensible multi-file convertor.}
  spec.homepage      = "https://github.com/hinastory/fileconv"
  spec.license       = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/hinastory/fileconv"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.3.0"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
end
