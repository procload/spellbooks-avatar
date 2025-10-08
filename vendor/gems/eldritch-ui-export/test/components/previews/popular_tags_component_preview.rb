# frozen_string_literal: true

# Lookbook previews for EldritchUi::PopularTagsComponent
class EldritchUi::PopularTagsComponentPreview < ViewComponent::Preview
  # @label Playground
  # @param target_input "Target input id (optional)"
  # @param title "Heading text"
  def playground(target_input: "interests", title: "Popular interests")
    input = helpers.tag.input(type: "text", id: target_input, class: "eld-text-input", placeholder: "Type interests...")
    component = render EldritchUi::PopularTagsComponent.new(target_input: target_input, title: title)
    helpers.safe_join([input, helpers.tag.br, component])
  end

  # @!group Basic
  def default
    render EldritchUi::PopularTagsComponent.new
  end

  def with_target_input
    input_id = "interests-input"
    input = helpers.tag.input(type: "text", id: input_id, class: "eld-text-input", placeholder: "Interests")
    component = render EldritchUi::PopularTagsComponent.new(target_input: input_id, title: "Pick some interests")
    helpers.safe_join([input, helpers.tag.br, component])
  end

  def with_custom_class
    render EldritchUi::PopularTagsComponent.new(title: "Trending tags", class: "mt-4")
  end
end

