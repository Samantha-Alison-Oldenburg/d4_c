$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "d4_c/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "d4_c"
  spec.version     = D4C::VERSION
  spec.authors     = ["Samantha Oldenburg"]
  spec.email       = ["samantha.oldenburg@avant.com"]
  spec.homepage    = "https://github.com/samanthaoldenburg/d4_c"
  spec.summary     = "Dirty Deeds Done Dirt Cheap"
  spec.description = "Hotpatch your rails server without shutting it down."
  spec.license     = "ISTG (read the ISTG-LICENSE file)"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 4.2.11"

  spec.add_dependency "sqlite3"
end
