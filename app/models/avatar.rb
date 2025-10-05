class Avatar
  include ActiveModel::Model
  include ActiveModel::Attributes

  CLASSES = ["Wizard", "Knight", "Ranger", "Scholar"].freeze
  TRAITS  = ["Brave", "Clever", "Kind", "Sneaky", "Curious"].freeze
  GENDERS = ["male", "female", "non-binary"].freeze

  attribute :name, :string
  attribute :gender, :string
  attribute :klass, :string
  attribute :traits, default: -> { [] }

  validates :name, presence: true
  validates :gender, inclusion: { in: GENDERS }
  validates :klass, inclusion: { in: CLASSES }
  validate :traits_are_valid

  def traits=(value)
    super(Array(value).reject(&:blank?))
  end

  def to_h
    {
      name: name,
      gender: gender,
      klass: klass,
      traits: traits
    }
  end

  def self.defaults
    default_attributes = {
      name: "Astra",
      gender: "non-binary",
      klass: "Wizard",
      traits: %w[Clever Curious]
    }

    avatar = new(default_attributes)
    raise ArgumentError, "Invalid avatar defaults" unless avatar.valid?

    avatar.to_h
  end

  private

  def traits_are_valid
    invalid_traits = traits - TRAITS
    return if invalid_traits.empty?

    errors.add(:traits, "include invalid selection: #{invalid_traits.to_sentence}")
  end
end
