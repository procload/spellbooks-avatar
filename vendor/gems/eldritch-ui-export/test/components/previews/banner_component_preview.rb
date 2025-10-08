# frozen_string_literal: true

# Lookbook previews for EldritchUi::BannerComponent
class EldritchUi::BannerComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param message "Banner message text"
  # @param variant select "Visual style variant" :variant_options
  # @param size select "Size" :size_options
  # @param alignment select "Text alignment" :alignment_options
  def playground(message: "Welcome to Eldritch UI!", variant: :default, size: :default, alignment: :center)
    render EldritchUi::BannerComponent.new(
      message: message,
      variant: variant,
      size: size,
      alignment: alignment
    )
  end

  # @!group Variants
  def default
    render EldritchUi::BannerComponent.new(message: "Default banner")
  end

  def success
    render EldritchUi::BannerComponent.new(message: "Success!", variant: :success)
  end

  def warning
    render EldritchUi::BannerComponent.new(message: "Heads up!", variant: :warning)
  end

  def error
    render EldritchUi::BannerComponent.new(message: "Something went wrong", variant: :error)
  end

  def dark
    render EldritchUi::BannerComponent.new(message: "Dark mode banner", variant: :dark)
  end

  # @!group Sizes
  def small
    render EldritchUi::BannerComponent.new(message: "Small banner", size: :small)
  end

  def large
    render EldritchUi::BannerComponent.new(message: "Large banner", size: :large)
  end

  # @!group Alignment
  def left_aligned
    render EldritchUi::BannerComponent.new(message: "Left aligned banner", alignment: :left)
  end

  def right_aligned
    render EldritchUi::BannerComponent.new(message: "Right aligned banner", alignment: :right)
  end

  private

  def variant_options
    %i[default success warning error dark]
  end

  def size_options
    %i[small default large]
  end

  def alignment_options
    %i[left center right]
  end
end

