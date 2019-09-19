pwd = File.expand_path("../", __FILE__)
$LOAD_PATH.unshift(pwd) unless $LOAD_PATH.include?(pwd)
load "jeans"

Gem::Specification.new do |spec|
  spec.name          = "jeans"
  spec.version       = Jeans::VERSION
  spec.authors       = ["Nick LaMuro"]
  spec.email         = ["nicklamuro@gmail.com"]

  spec.summary       = "BlueJeans CLI and address book"
  spec.description   = "BlueJeans CLI and address book"
  spec.homepage      = "https://github.com/NickLaMuro/jeans"
  spec.license       = "MIT"

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  spec.files         = %w[
    jeans
    jeans.gemspec
    README.md
    LICENSE.txt
    contrib/completion/jeans.bash
  ]

  spec.bindir        = "."
  spec.executables   = %w[ jeans ]
  spec.require_paths = %w[ .     ]

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
