require "test_helper"

class AvatarsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_avatar_url
    assert_response :success
  end

  test "should create avatar" do
    post avatars_url, params: {
      avatar: {
        name: "Nova",
        gender: "female",
        klass: "Wizard",
        traits: ["Brave"]
      }
    }

    assert_response :success
  end

  test "should get edit" do
    get edit_avatar_url
    assert_response :success
  end

  test "should update avatar" do
    patch avatar_url, params: {
      avatar: {
        name: "Nova",
        gender: "male",
        klass: "Knight",
        traits: ["Kind", "Clever"]
      }
    }

    assert_response :success
  end
end
