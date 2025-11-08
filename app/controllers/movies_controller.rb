class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
   skip_before_action :verify_authenticity_token, only: [:create] if Rails.env.development?

  # GET /movies
  # HTTP Verb: GET
  # URL: /movies
  def index
    @movies = Movie.order(created_at: :desc)
  end

  # GET /movies/:id
  # HTTP Verb: GET
  # URL: /movies/:id
  def show
    # @movie is set by set_movie
  end

  # GET /movies/new
  # HTTP Verb: GET
  # URL: /movies/new
  def new
    @movie = Movie.new
  end

  # POST /movies
  # HTTP Verb: POST
  # URL: /movies
  def create
  @movie = Current.user.movies.build(movie_params)
  if @movie.save
    redirect_to @movie, notice: "Movie was successfully created."
  else
    flash.now[:alert] = "There were errors creating the movie."
    render :new, status: :unprocessable_entity
  end
end

  # GET /movies/:id/edit
  # HTTP Verb: GET
  # URL: /movies/:id/edit
  def edit
    # @movie is set by set_movie
  end

  # PATCH/PUT /movies/:id
  # HTTP Verb: PATCH or PUT
  # URL: /movies/:id
  def update
    if @movie.update(movie_params)
      redirect_to @movie, notice: "Movie was successfully updated."
    else
      flash.now[:alert] = "There were errors updating the movie."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /movies/:id
  # HTTP Verb: DELETE
  # URL: /movies/:id
  def destroy
    @movie.destroy
    redirect_to movies_path, notice: "Movie was successfully deleted."
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :director, :release_year, :rating)
  end
end
