require "test_helper"

class AvatarsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_avatar_url
    assert_response :success
  end

  test "should get create" do
    post avatars_url, params: {
      avatar: {
        name: "Test Adventurer",
        gender: "non-binary",
        klass: "Wizard",
        traits: %w[Brave]
      }
    }
    assert_response :success
  end
end
