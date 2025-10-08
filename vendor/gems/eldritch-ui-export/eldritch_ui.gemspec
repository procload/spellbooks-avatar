# frozen_string_literal: true

require_relative "lib/eldritch_ui/version"

Gem::Specification.new do |spec|
  spec.name        = "eldritch_ui"
  spec.version     = EldritchUi::VERSION
  spec.authors     = ["Your Name"]
  spec.email       = ["your.email@example.com"]
  spec.homepage    = "https://github.com/yourusername/eldritch_ui"
  spec.summary     = "A magical UI component library for Rails"
  spec.description = "Eldritch UI is a comprehensive ViewComponent-based design system with 3-tier design tokens, 36 components, and 1,200+ Heroicons."
  spec.license     = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0"
  spec.add_dependency "view_component", "~> 3.0"

  spec.add_development_dependency "lookbook", "~> 2.0"
end
