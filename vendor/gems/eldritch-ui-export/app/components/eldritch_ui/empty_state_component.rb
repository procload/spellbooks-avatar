# frozen_string_literal: true

module EldritchUi
  class EmptyStateComponent < ViewComponent::Base
    VALID_SIZES = %i[default large].freeze
    VALID_ICON_SIZES = %i[small default large].freeze

    # @param title [String] The main heading text (required)
    # @param description [String] Supporting text below the title (optional)
    # @param icon_name [String] Icon to display above the title (optional)
    # @param icon_size [Symbol] Size of the icon (:small, :default, :large)
    # @param size [Symbol] Overall component size (:default, :large)
    # @param html_attributes [Hash] Additional HTML attributes for the container
    def initialize(
      title:,
      description: nil,
      icon_name: nil,
      icon_size: :default,
      size: :default,
      **html_attributes
    )
      @title = title
      @description = description
      @icon_name = icon_name
      @icon_size = validate_enum(icon_size, VALID_ICON_SIZES, :default)
      @size = validate_enum(size, VALID_SIZES, :default)
      @html_attributes = html_attributes.freeze
    end

    # Slots for flexible content
    renders_one :primary_action, types: {
      button: lambda { |**args|
        EldritchUi::ButtonComponent.new(**args)
      },
      link: lambda { |href:, **args|
        content_tag(:a, href: href, **link_attributes(args)) do
          args[:label] || "Learn More"
        end
      }
    }

    renders_many :secondary_actions, types: {
      button: lambda { |**args|
        EldritchUi::ButtonComponent.new(**args)
      },
      link: lambda { |href:, **args|
        content_tag(:a, href: href, **link_attributes(args)) do
          args[:label] || "Learn More"
        end
      }
    }

    renders_one :custom_content

    private

    attr_reader :title, :description, :icon_name, :icon_size, :size, :html_attributes

    def validate_enum(value, valid_values, default)
      valid_values.include?(value.to_sym) ? value.to_sym : default
    end

    def component_attributes
      attrs = html_attributes.dup
      custom_classes = attrs.delete(:class).to_s.split
      default_classes = default_css_classes.split
      final_classes = (default_classes + custom_classes).uniq.join(" ")

      {
        class: final_classes,
        role: "region",
        "aria-labelledby": title_id,
        **attrs
      }
    end

    def default_css_classes
      classes = [ "eld-empty-state" ]
      classes << "eld-empty-state--#{size}" if size != :default
      classes.join(" ")
    end

    def title_id
      @title_id ||= "empty-state-title-#{SecureRandom.hex(4)}"
    end

    def title_classes
      classes = [ "eld-empty-state__title" ]
      classes << "eld-empty-state__title--#{size}" if size != :default
      classes.join(" ")
    end

    def description_classes
      classes = [ "eld-empty-state__description" ]
      classes << "eld-empty-state__description--#{size}" if size != :default
      classes.join(" ")
    end

    def icon_classes
      classes = [ "eld-empty-state__icon" ]
      classes << "eld-empty-state__icon--#{icon_size}" if icon_size != :default
      classes.join(" ")
    end

    def actions_classes
      classes = [ "eld-empty-state__actions" ]
      classes << "eld-empty-state__actions--#{size}" if size != :default
      classes.join(" ")
    end

    def link_attributes(args)
      link_attrs = args.except(:label)
      link_classes = [ "eld-empty-state__link" ]
      link_classes += link_attrs.delete(:class).to_s.split
      link_attrs[:class] = link_classes.uniq.join(" ")
      link_attrs
    end

    def show_icon?
      icon_name.present?
    end

    def show_description?
      description.present?
    end

    def show_actions?
      primary_action.present? || secondary_actions.present?
    end

    def show_custom_content?
      custom_content.present?
    end
  end
end
