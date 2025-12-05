class ReviewsController < ApplicationController
  before_action :set_movie
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /movies/:movie_id/reviews
  def index
    @reviews = @movie.reviews.order(created_at: :desc)
  end

  # GET /movies/:movie_id/reviews/:id
  def show
  end

  # GET /movies/:movie_id/reviews/new
  def new
    @review = @movie.reviews.build
  end

  # POST /movies/:movie_id/reviews
  def create
    @review = @movie.reviews.build(review_params)
    if @review.save
      redirect_to movie_review_path(@movie, @review), notice: "Review created successfully."
    else
      flash.now[:alert] = "There were errors creating the review."
      render :new, status: :unprocessable_entity
    end
  end

  # GET /movies/:movie_id/reviews/:id/edit
  def edit
  end

  # PATCH/PUT /movies/:movie_id/reviews/:id
  def update
    if @review.update(review_params)
      redirect_to movie_review_path(@movie, @review), notice: "Review updated successfully."
    else
      flash.now[:alert] = "There were errors updating the review."
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /movies/:movie_id/reviews/:id
  def destroy
    @review.destroy
    redirect_to movie_reviews_path(@movie), notice: "Review deleted successfully."
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_review
    @review = @movie.reviews.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :body, :rating)
  end
end
