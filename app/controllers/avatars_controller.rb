class AvatarsController < ApplicationController
  before_action :assign_form_options

  def new
    @avatar_form = Avatar.new
    @current_avatar = find_current_avatar
  end

  def create
    @avatar_form = Avatar.new(avatar_params)

    if @avatar_form.save
      store_avatar_id(@avatar_form.id)
      ImageGenerationJob.perform_later(
        avatar_id: @avatar_form.id
      )
      redirect_to new_avatar_path
    else
      @current_avatar = nil
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @avatar_form = find_current_avatar || Avatar.new(Avatar.defaults)
    @current_avatar = @avatar_form.persisted? ? @avatar_form : nil
  end

  def update
    @avatar_form = find_current_avatar || Avatar.new

    if @avatar_form.update(avatar_params)
      ImageGenerationJob.perform_later(
        avatar_id: @avatar_form.id
      )
      redirect_to edit_avatar_path
    else
      @current_avatar = @avatar_form.persisted? ? @avatar_form : nil
      render :edit, status: :unprocessable_entity
    end
  end

  def preview
    @avatar = find_current_avatar
    render layout: false
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

  def store_avatar_id(avatar_id)
    session[:current_avatar_id] = avatar_id
  end

  def find_current_avatar
    return nil unless session[:current_avatar_id]

    Avatar.find_by(id: session[:current_avatar_id])
  end
end
