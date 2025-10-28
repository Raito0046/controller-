class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review, only: %i[show edit update destroy]

  # GET /movies/:movie_id/reviews
  # HTTP Verb: GET
  # URL: /movies/:movie_id/reviews
  def index
    @reviews = @movie.reviews.order(created_at: :desc)
  end

  # GET /movies/:movie_id/reviews/new
  # HTTP Verb: GET
  # URL: /movies/:movie_id/reviews/new
  def new
    @review = @movie.reviews.build
  end

  # POST /movies/:movie_id/reviews
  # HTTP Verb: POST
  # URL: /movies/:movie_id/reviews
  def create
    @review = @movie.reviews.build(review_params)
    if @review.save
      redirect_to movie_review_path(@movie, @review), notice: "Review was successfully created."
    else
      flash.now[:alert] = "Please correct the errors below."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /movies/:movie_id/reviews/:id
  # HTTP Verb: GET
  # URL: /movies/:movie_id/reviews/:id
  def show
  end

  # GET /movies/:movie_id/reviews/:id/edit
  # HTTP Verb: GET
  # URL: /movies/:movie_id/reviews/:id/edit
  def edit
  end

  # PATCH/PUT /movies/:movie_id/reviews/:id
  # HTTP Verb: PATCH or PUT
  # URL: /movies/:movie_id/reviews/:id
  def update
    if @review.update(review_params)
      redirect_to movie_review_path(@movie, @review), notice: "Review was successfully updated."
    else
      flash.now[:alert] = "Please correct the errors below."
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def review_params
    params.require(:review).permit(:reviewer, :rating, :body)
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end
end