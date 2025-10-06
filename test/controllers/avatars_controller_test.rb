require "test_helper"

class AvatarsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_avatar_url
    assert_response :success
  end

  test "should create avatar" do
    post avatar_url, params: {
      avatar: {
        name: "Nova",
        gender: "female",
        klass: "Wizard",
        traits: ["Brave"]
      }
    }

    assert_redirected_to new_avatar_path
    follow_redirect!
    assert_response :success
    assert_match "Submitted", @response.body
  end

  test "should get edit" do
    get edit_avatar_url
    assert_response :success
    assert_select "input[name='avatar[name]'][value='Astra']"
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

    assert_redirected_to edit_avatar_path
  end

  test "should prefill edit form with persisted avatar" do
    patch avatar_url, params: {
      avatar: {
        name: "Lyra",
        gender: "female",
        klass: "Ranger",
        traits: ["Kind"]
      }
    }

    get edit_avatar_url

    assert_response :success
    assert_select "input[name='avatar[name]'][value='Lyra']"
  end

  test "should show errors when create params are invalid" do
    post avatar_url, params: {
      avatar: {
        name: "",
        gender: "robot",
        klass: "Wizard",
        traits: ["Curious"]
      }
    }

    assert_response :unprocessable_entity
    assert_select "div.form-errors"
  end

  test "should show errors when update params are invalid" do
    patch avatar_url, params: {
      avatar: {
        name: "",
        gender: "male",
        klass: "Knight",
        traits: ["Invisible"]
      }
    }

    assert_response :unprocessable_entity
    assert_select "div.form-errors"
  end
end
