$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "better_rails_admin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "better_rails_admin"
  s.version     = BetterRailsAdmin::VERSION
  s.authors     = ["mcasimir"]
  s.email       = ["maurizio.cas@gmail.com"]
  s.homepage    = "https://github.com/mcasimir/better_rails_admin"
  s.summary     = "RailsAdmin bug fixes and better Dsl."
  s.description = "RailsAdmin bug fixes and better Dsl: works as expected without CanCan, sort ui for nested models having position, getting rid of ugly default dashboard and more."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.8"
end
