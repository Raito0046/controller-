class ReviewsController < ApplicationController
  before_action :set_movie

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

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end