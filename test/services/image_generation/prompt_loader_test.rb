# frozen_string_literal: true

require "test_helper"

module ImageGeneration
  class PromptLoaderTest < ActiveSupport::TestCase
    test "renders avatar template with inputs and examples" do
      loader = PromptLoader.new

      prompt = loader.load("avatar", attributes: { persona: "storm mage", eye_color: "violet" })

      assert_equal "You are the Spellbooks avatar director. Maintain brand cohesion by blending heroic fantasy costuming with modern, inclusive styling and cinematic lighting.", prompt.system_prompt
      assert_includes prompt.text, "storm mage"
      assert_includes prompt.text, "Eye color: violet"
      assert_includes prompt.text, "Reference example images:"
      assert_includes prompt.text, "- Arcane strategist: https://storage.googleapis.com/spellbooks-reference/avatars/arcane-strategist.png (Teal edge lighting, brushed metal filigree, focused gaze.)"
      assert_equal 2, prompt.example_images.length
    end
  end
end
