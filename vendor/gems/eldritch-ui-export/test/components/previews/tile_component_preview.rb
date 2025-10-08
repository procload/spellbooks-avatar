# frozen_string_literal: true

class EldritchUi::TileComponentPreview < ViewComponent::Preview
  # 🎮 Tile playground! 🎮
  # ----------------------
  # You can use the controls in the 'Params' section
  # to set tile property values on the fly.
  #
  # @param content "Tile text content"
  # @param selection_mode select "Selection behavior" :selection_mode_options
  # @param selected [Boolean] toggle "Is the tile selected?"
  # @param value "Value for form submission"
  # @param name "Name for radio grouping"
  # @param size select "Size of the tile" :size_options
  # @param disabled [Boolean] toggle "Is the tile disabled?"
  # @param href "Optional URL for navigation"
  # @param turbo_method select "Turbo method for navigation" :turbo_method_options
  # @param turbo_frame "Turbo frame target"
  # @param aria_label "ARIA label for accessibility"
  def playground(
    content: "Interactive Tile",
    selection_mode: :none,
    selected: false,
    value: "tile_value",
    name: "tile_group",
    size: :medium,
    disabled: false,
    href: "",
    turbo_method: "",
    turbo_frame: "",
    aria_label: ""
  )
    render EldritchUi::TileComponent.new(
      selection_mode: selection_mode,
      selected: selected,
      value: value,
      name: name.present? ? name : nil,
      size: size,
      disabled: disabled,
      href: href.present? ? href : nil,
      turbo_method: turbo_method.present? ? turbo_method : nil,
      turbo_frame: turbo_frame.present? ? turbo_frame : nil,
      aria_label: aria_label.present? ? aria_label : nil
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      content
    end
  end

  # Default tile without selection behavior
  # @!group Basic Examples
  def default
    render EldritchUi::TileComponent.new do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-5 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"
        end
      end
      "Default Tile"
    end
  end

  # Single selection tile for forms
  # @!group Selection Examples
  def single_selection
    render EldritchUi::TileComponent.new(
      selection_mode: :single,
      name: "subject",
      value: "math",
      size: :medium
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-7 3c.55 0 1 .45 1 1s-.45 1-1 1-1-.45-1-1 .45-1 1-1zm2 14H7v-2h7v2zm3-4H7v-2h10v2zm0-4H7V7h10v2z"
        end
      end
      "Math"
    end
  end

  # Multiple selection tile
  # @!group Selection Examples
  def multiple_selection
    render EldritchUi::TileComponent.new(
      selection_mode: :multiple,
      value: "premium",
      selected: true,
      size: :medium
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      "Premium Features"
    end
  end

  # Subject selector group
  # @!group Selection Examples
  def subject_selector_math
    render EldritchUi::TileComponent.new(
      size: :small,
      selection_mode: :single,
      name: "subject",
      value: "math",
      selected: true
    ) do |tile|
      tile.with_icon do
        # Calculator icon from Heroicons
        icon("calculator", library: "heroicons", variant: "outline")
      end
      "Math"
    end
  end

  # Navigation tile
  # @!group Navigation Examples
  def navigation
    render EldritchUi::TileComponent.new(
      href: "/dashboard",
      size: :medium
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"
        end
      end
      "Dashboard"
    end
  end

  # Small size tile
  # @!group Size Examples
  def small_size
    render EldritchUi::TileComponent.new(size: :small) do |tile|
      tile.with_icon do
        content_tag :svg, width: "24", height: "24", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      "Small"
    end
  end

  # Subject selector size tile (matches Figma design)
  # @!group Size Examples
  def subject_selector
    render EldritchUi::TileComponent.new(
      size: :small,
      selection_mode: :single,
      name: "subject",
      value: "math"
    ) do |tile|
      tile.with_icon do
        # Calculator icon from Heroicons
        icon("calculator", library: "heroicons", variant: "outline")
      end
      "Math"
    end
  end

  # Large size tile
  # @!group Size Examples
  def large_size
    render EldritchUi::TileComponent.new(size: :large) do |tile|
      tile.with_icon do
        content_tag :svg, width: "48", height: "48", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      "Large"
    end
  end

  # Tile with subtitle
  # @!group Advanced Examples
  def with_subtitle
    render EldritchUi::TileComponent.new(
      selection_mode: :single,
      name: "plan",
      value: "pro",
      selected: true,
      size: :medium
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      tile.with_subtitle { "$29/month" }
      "Pro Plan"
    end
  end

  # Disabled tile
  # @!group State Examples
  def disabled_state
    render EldritchUi::TileComponent.new(
      size: :medium,
      disabled: true
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      "Disabled"
    end
  end

  # Selected and disabled tile
  # @!group State Examples
  def selected_disabled
    render EldritchUi::TileComponent.new(
      size: :medium,
      disabled: true,
      selected: true
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"
        end
      end
      "Selected & Disabled"
    end
  end

  # Turbo POST navigation
  # @!group Turbo Examples
  def turbo_post
    render EldritchUi::TileComponent.new(
      href: "/posts",
      turbo_method: "post",
      turbo_frame: "posts_frame",
      size: :medium
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"
        end
      end
      "Create Post"
    end
  end

  # Turbo DELETE navigation
  # @!group Turbo Examples
  def turbo_delete
    render EldritchUi::TileComponent.new(
      href: "/posts/1",
      turbo_method: "delete",
      size: :medium
    ) do |tile|
      tile.with_icon do
        content_tag :svg, width: "32", height: "32", viewBox: "0 0 24 24", fill: "currentColor" do
          content_tag :path, nil, d: "M3 13h8V3H3v10zm0 8h8v-6H3v6zm10 0h8V11h-8v10zm0-18v6h8V3h-8z"
        end
      end
      "Delete Post"
    end
  end

  private

  def selection_mode_options
    [:none, :single, :multiple]
  end

  def size_options
    [:small, :medium, :large]
  end

  def turbo_method_options
    ["", "get", "post", "patch", "put", "delete"]
  end

  private


end 