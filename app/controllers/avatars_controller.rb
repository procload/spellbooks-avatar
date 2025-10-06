class AvatarsController < ApplicationController
  before_action :assign_form_options

  def new
    @avatar_form = Avatar.new
    @submitted_avatar = Avatar.new(current_avatar_attributes) if current_avatar_attributes
  end

  def create
    @avatar_form = Avatar.new(avatar_params.to_h)

    if @avatar_form.valid?
      persist_avatar(@avatar_form)
      redirect_to new_avatar_path
    else
      @submitted_avatar = nil
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @avatar_form = Avatar.new(current_avatar_attributes || Avatar.defaults)
    @submitted_avatar = Avatar.new(current_avatar_attributes) if current_avatar_attributes
  end

  def update
    @avatar_form = Avatar.new(avatar_params.to_h)

    if @avatar_form.valid?
      persist_avatar(@avatar_form)
      redirect_to edit_avatar_path
    else
      @submitted_avatar = nil
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def assign_form_options
    @classes = Avatar::CLASSES
    @traits  = Avatar::TRAITS
    @genders = Avatar::GENDERS
  end

  def avatar_params
    params.require(:avatar).permit(:name, :gender, :klass, traits: [])
  end

  def persist_avatar(avatar)
    session[:avatar] = avatar.to_h
  end

  def current_avatar_attributes
    return nil unless session[:avatar].is_a?(Hash)

    session[:avatar].symbolize_keys
  rescue StandardError
    nil
  end
end
