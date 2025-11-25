class PostersController < ApplicationController
  before_action :set_poster, only: %i[show edit update destroy]

  def index
    @posters = Poster.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @poster = Poster.new
  end

  def create
    @poster = Poster.new(poster_params)
    # If you have current_user, set ownership automatically
    @poster.user = current_user if respond_to?(:current_user) && @poster.user.nil?

    if @poster.save
      redirect_to @poster, notice: "Poster was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @poster.update(poster_params)
      redirect_to @poster, notice: "Poster was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @poster.destroy
    redirect_to posters_path, notice: "Poster was successfully destroyed."
  end

  private

  def set_poster
    @poster = Poster.find(params[:id])
  end

  def poster_params
    params.require(:poster).permit(:title, :description, :image, :user_id)
  end
end