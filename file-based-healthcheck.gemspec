# frozen_string_literal: true

require_relative "lib/file_based_healthcheck/version"

Gem::Specification.new do |spec|
  spec.name          = "file-based-healthcheck"
  spec.version       = FileBasedHealthcheck::VERSION
  spec.authors       = ["Karol Galanciak"]
  spec.email         = ["karol.galanciak@gmail.com", "karol@bookingsync.com", "dev@bookingsync.com"]

  spec.summary       = "A gem to use a healthcheck for readiness and liveness probes in Kubernetes."
  spec.description   = "A gem to use a healthcheck for readiness and liveness probes in Kubernetes."
  spec.homepage      = "https://github.com/BookingSync/file-based-healthcheck"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/BookingSync/file-based-healthcheck."
  spec.metadata["changelog_uri"] = "https://github.com/BookingSync/file-based-healthcheck/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "activesupport", ">= 3.2"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
