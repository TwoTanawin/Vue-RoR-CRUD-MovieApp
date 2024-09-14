class MoviesController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create, :update, :destroy]

  def index
    movies = Movie.all
    render json: { movies: movies.as_json }, status: :ok
  end

  def show
    movie = Movie.find(params[:id])
    render json: { movie: movie.as_json }, status: :ok
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Not found" }, status: :not_found
  end

  def create
    movie = Movie.new(movie_params)
    if movie.save
      render json: { movie: movie.as_json }, status: :created
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    # puts "Hello Update"
    movie = Movie.find(params[:id])
    if movie.update(movie_params)
      render json: { movie: movie.as_json }, status: :ok
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Not found" }, status: :not_found
  end

  def destroy
    # puts "Hello Delete"
    movie = Movie.find(params[:id])
    if movie.destroy
      render json: { status: 200, id: movie.id }
    else
      render json: { errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  rescue ActiveRecord::RecordNotFound
    render json: { errors: "Not found" }, status: :not_found
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description)
  end
end
