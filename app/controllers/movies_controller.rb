class MoviesController < ApplicationController
  def index
    @movies = Movie.all
    render json: @movies
  end

  def recommendations
    favorite_movies = User.find(params[:user_id]).favorites
    @recommendations = RecommendationEngine.new(favorite_movies).recommendations
    render json: @recommendations
  end

  def user_rented_movies
    @rented = User.find(params[:user_id]).rented
    render json: @rented
  end

  def rent
    user = User.find(params[:user_id])
    movie = Movie.find(params[:id])
    
    if movie.available_copies <= 0
      render json: {"message": "No copies available.", "success": false}, status: 400
      return
    end

    if movie.save
      movie.available_copies -= 1
      user.rented << movie
      render json: movie
    else
      render json: movie.errors, status: 500
    end
  
  end
end