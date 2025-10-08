class Avatar < ApplicationRecord
  CLASSES = ["Wizard", "Knight", "Ranger", "Scholar"].freeze
  TRAITS  = ["Brave", "Clever", "Kind", "Sneaky", "Curious"].freeze
  GENDERS = ["male", "female", "non-binary"].freeze

  STATUSES = %w[pending processing completed failed].freeze

  broadcasts_refreshes

  serialize :traits, coder: JSON, type: Array

  enum :status, STATUSES.index_by(&:itself), default: :pending

  validates :name, presence: true, length: { maximum: 50 }
  validates :gender, inclusion: { in: GENDERS, message: "must be male, female, or non-binary" }
  validates :klass, inclusion: { in: CLASSES, message: "must be one of: #{CLASSES.join(', ')}" }
  validate :traits_are_valid

  def traits=(value)
    super(Array(value).reject(&:blank?))
  end

  def image_present?
    image_data.present? && image_mime_type.present?
  end

  def data_url
    return nil unless image_present?

    "data:#{image_mime_type};base64,#{image_data}"
  end

  def processing?
    pending? || processing_status?
  end

  def processing_status?
    status == "processing"
  end

  def self.defaults
    {
      name: "Astra",
      gender: "non-binary",
      klass: "Wizard",
      traits: %w[Clever Curious]
    }
  end

  private

  def traits_are_valid
    invalid_traits = traits - TRAITS
    return if invalid_traits.empty?

    errors.add(:traits, "include invalid selection: #{invalid_traits.to_sentence}")
  end
end
