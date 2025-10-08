# frozen_string_literal: true

module EldritchUi
  class PopularTagsComponent < ViewComponent::Base
    def initialize(
      target_input: nil,
      title: "Popular interests",
      **html_attributes
    )
      @target_input = target_input
      @title = title
      @html_attributes = html_attributes.freeze
    end

    private

    attr_reader :target_input, :title, :html_attributes

    def popular_tags
      [
        "Minecraft", "LEGO", "NBA", "Soccer", "Pokemon", "Fortnite",
        "Dogs", "Cats", "Space", "Dinosaurs", "Art", "Music",
        "Cooking", "Nature", "Sports", "Movies", "Books", "Dancing"
      ]
    end

    def container_attributes
      attrs = html_attributes.deep_dup
      custom_classes = attrs.delete(:class).to_s.split

      attrs[:class] = (default_css_classes.split + custom_classes).uniq.join(" ")
      attrs["data-controller"] = "popular-tags"
      attrs["data-popular-tags-target-value"] = target_input if target_input

      attrs.compact
    end

    def default_css_classes
      "eld-popular-tags"
    end
  end
end
