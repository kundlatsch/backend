class RecommendationEngine
  def initialize(favorite_movies_ids)
    @favorite_movies_ids = favorite_movies_ids
  end

  def recommendations
    genres = Movie.where(id: @favorite_movies_ids).pluck(:genre)
    common_genres = genres.group_by{ |e| e }.sort_by{ |k, v| -v.length }.map(&:first).take(3)
    Movie.where(genre: common_genres).order(rating: :desc).limit(10)
  end

  private

end