class AvatarsController < ApplicationController
  CLASSES = [ "Wizard", "Knight", "Ranger", "Scholar" ].freeze
  TRAITS  = [ "Brave", "Clever", "Kind", "Sneaky", "Curious" ].freeze
  GENDERS = [ "male", "female", "non-binary" ].freeze

  def new
    @classes = CLASSES
    @traits  = TRAITS
    @genders = GENDERS
  end

  def create
    @classes = CLASSES
    @traits  = TRAITS
    @genders = GENDERS

    @input = params.require(:avatar).permit(:name, :gender, :klass, traits: [])
    render :new
  end
end
