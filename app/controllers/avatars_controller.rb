class AvatarsController < ApplicationController
  CLASSES = ["Wizard", "Knight", "Ranger", "Scholar"].freeze
  TRAITS  = ["Brave", "Clever", "Kind", "Sneaky", "Curious"].freeze
  GENDERS = ["male", "female", "non-binary"].freeze

  before_action :assign_form_options

  def new
    @form_avatar = {}
    @submitted_avatar = nil
  end

  def create
    @form_avatar = avatar_params.to_h.symbolize_keys
    @submitted_avatar = @form_avatar

    render :new
  end

  def edit
    @form_avatar = default_avatar_attributes
    @submitted_avatar = nil
  end

  def update
    @form_avatar = avatar_params.to_h.symbolize_keys
    @submitted_avatar = @form_avatar

    render :edit
  end

  private

  def assign_form_options
    @classes = CLASSES
    @traits  = TRAITS
    @genders = GENDERS
  end

  def avatar_params
    params.require(:avatar).permit(:name, :gender, :klass, traits: [])
  end

  def default_avatar_attributes
    {
      name: "Astra",
      gender: "non-binary",
      klass: "Wizard",
      traits: %w[Clever Curious]
    }
  end
end
