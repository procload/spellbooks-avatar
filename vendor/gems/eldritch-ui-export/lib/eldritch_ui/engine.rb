# frozen_string_literal: true

module EldritchUi
  class Engine < ::Rails::Engine
    isolate_namespace EldritchUi

    # Configure ViewComponent
    initializer "eldritch_ui.view_component" do |app|
      if app.config.respond_to?(:view_component)
        app.config.view_component.preview_paths << root.join("test/components/previews")
      end
    end

    # Add assets path for Propshaft
    initializer "eldritch_ui.assets" do |app|
      # Add to Propshaft load paths
      app.config.assets.paths << root.join("app/assets/stylesheets") if app.config.respond_to?(:assets)

      # For older Sprockets compatibility
      if app.config.respond_to?(:assets) && app.config.assets.respond_to?(:precompile)
        app.config.assets.precompile += %w[eldritch_ui.css]
      end
    end

    # Register Stimulus controllers
    initializer "eldritch_ui.importmap", before: "importmap" do |app|
      if app.config.respond_to?(:importmap)
        app.config.importmap.paths << root.join("config/importmap.rb")
      end
    end
  end
end
