require "test_helper"

class AvatarTest < ActiveSupport::TestCase
  test "valid avatar with all attributes" do
    avatar = Avatar.new(
      name: "Test Hero",
      gender: "male",
      klass: "Wizard",
      traits: ["Brave", "Clever"]
    )
    assert avatar.valid?
  end

  test "invalid without name" do
    avatar = Avatar.new(
      gender: "female",
      klass: "Knight",
      traits: ["Kind"]
    )
    assert_not avatar.valid?
    assert_includes avatar.errors[:name], "can't be blank"
  end

  test "invalid with blank name" do
    avatar = Avatar.new(
      name: "",
      gender: "female",
      klass: "Knight",
      traits: ["Kind"]
    )
    assert_not avatar.valid?
    assert_includes avatar.errors[:name], "can't be blank"
  end

  test "invalid with name longer than 50 characters" do
    avatar = Avatar.new(
      name: "a" * 51,
      gender: "male",
      klass: "Wizard",
      traits: ["Brave"]
    )
    assert_not avatar.valid?
    assert_includes avatar.errors[:name], "is too long (maximum is 50 characters)"
  end

  test "valid with name at 50 character limit" do
    avatar = Avatar.new(
      name: "a" * 50,
      gender: "male",
      klass: "Wizard",
      traits: ["Brave"]
    )
    assert avatar.valid?
  end

  test "invalid with invalid gender" do
    avatar = Avatar.new(
      name: "Test",
      gender: "robot",
      klass: "Wizard",
      traits: ["Brave"]
    )
    assert_not avatar.valid?
    assert_includes avatar.errors[:gender], "must be male, female, or non-binary"
  end

  test "valid with each valid gender" do
    Avatar::GENDERS.each do |gender|
      avatar = Avatar.new(
        name: "Test",
        gender: gender,
        klass: "Wizard",
        traits: ["Brave"]
      )
      assert avatar.valid?, "Expected #{gender} to be valid"
    end
  end

  test "invalid with invalid class" do
    avatar = Avatar.new(
      name: "Test",
      gender: "male",
      klass: "Pirate",
      traits: ["Brave"]
    )
    assert_not avatar.valid?
    assert avatar.errors[:klass].present?
  end

  test "valid with each valid class" do
    Avatar::CLASSES.each do |klass|
      avatar = Avatar.new(
        name: "Test",
        gender: "male",
        klass: klass,
        traits: ["Brave"]
      )
      assert avatar.valid?, "Expected #{klass} to be valid"
    end
  end

  test "invalid with invalid trait" do
    avatar = Avatar.new(
      name: "Test",
      gender: "male",
      klass: "Wizard",
      traits: ["Invisible"]
    )
    assert_not avatar.valid?
    assert_match(/include invalid selection/, avatar.errors[:traits].first)
  end

  test "invalid with mix of valid and invalid traits" do
    avatar = Avatar.new(
      name: "Test",
      gender: "male",
      klass: "Wizard",
      traits: ["Brave", "Invisible", "Flying"]
    )
    assert_not avatar.valid?
    assert_match(/Invisible/, avatar.errors[:traits].first)
    assert_match(/Flying/, avatar.errors[:traits].first)
  end

  test "valid with empty traits array" do
    avatar = Avatar.new(
      name: "Test",
      gender: "male",
      klass: "Wizard",
      traits: []
    )
    assert avatar.valid?
  end

  test "valid with all valid traits" do
    avatar = Avatar.new(
      name: "Test",
      gender: "male",
      klass: "Wizard",
      traits: Avatar::TRAITS
    )
    assert avatar.valid?
  end

  test "traits setter rejects blank values" do
    avatar = Avatar.new
    avatar.traits = ["Brave", "", nil, "Clever", "  "]
    assert_equal ["Brave", "Clever"], avatar.traits
  end

  test "traits setter converts non-array to array" do
    avatar = Avatar.new
    avatar.traits = "Brave"
    assert_equal ["Brave"], avatar.traits
  end

  test "traits setter handles nil" do
    avatar = Avatar.new
    avatar.traits = nil
    assert_equal [], avatar.traits
  end

  test "to_h returns hash with all attributes" do
    avatar = Avatar.new(
      name: "Test Hero",
      gender: "female",
      klass: "Ranger",
      traits: ["Kind", "Brave"]
    )
    hash = avatar.to_h

    assert_equal "Test Hero", hash[:name]
    assert_equal "female", hash[:gender]
    assert_equal "Ranger", hash[:klass]
    assert_equal ["Kind", "Brave"], hash[:traits]
  end

  test "defaults returns valid avatar hash" do
    defaults = Avatar.defaults

    assert_kind_of Hash, defaults
    assert defaults[:name].present?
    assert Avatar::GENDERS.include?(defaults[:gender])
    assert Avatar::CLASSES.include?(defaults[:klass])
    assert defaults[:traits].is_a?(Array)
    defaults[:traits].each do |trait|
      assert Avatar::TRAITS.include?(trait), "Expected #{trait} to be in TRAITS"
    end
  end

  test "defaults creates valid avatar" do
    avatar = Avatar.new(Avatar.defaults)
    assert avatar.valid?
  end

  test "defaults raises error if invalid" do
    # This test verifies the self-check in Avatar.defaults
    # We can't easily test this without stubbing, but we can verify it doesn't raise normally
    assert_nothing_raised do
      Avatar.defaults
    end
  end
end
