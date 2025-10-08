class AvatarsController < ApplicationController
  before_action :assign_form_options, except: [:index, :show]

  def index
    @avatars = Avatar.order(created_at: :desc)
  end

  def show
    @avatar = Avatar.find(params[:id])
  end

  def new
    session[:current_avatar_id] = nil  # Clear old session for fresh start
    @avatar_form = Avatar.new
    @current_avatar = nil
  end

  def create
    @avatar_form = Avatar.new(avatar_params)

    if @avatar_form.save
      store_avatar_id(@avatar_form.id)
      ImageGenerationJob.perform_later(
        avatar_id: @avatar_form.id
      )

      respond_to do |format|
        format.html { redirect_to avatars_path, notice: "Avatar is being generated!" }
        format.turbo_stream
      end
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
    @avatar_form = Avatar.find(params[:id])

    if @avatar_form.update(avatar_params)
      ImageGenerationJob.perform_later(
        avatar_id: @avatar_form.id
      )
      redirect_to avatar_path(@avatar_form), notice: "Avatar is being regenerated!"
    else
      @current_avatar = @avatar_form
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
