class Rating
  include Mongoid::Document
  field :user_id, type: Integer
  field :movie_id, type: Integer
  field :rating, type: Integer

  def self.get_average_ratings(movie_id)
    return nil unless (movie_id or movie_id.is_a?(Integer))
    return Rating.where(movie_id: movie_id.to_i).avg(:rating)
  end

  def self.get_user_movies(user_id)
    return nil unless (user_id or user_id.is_a?(Integer))
    return Ratings.where(user_id: user_id.to_i).distinct(:movie_id)
  end

  def self.get_best_movies
    return nil
    Rating.aggregate([
                       {$match => {"valid" => true}},
                       {$sort => {"rating" => -1}},
                       {$group => {"_id":null,"avg" => {$avg => "$rating"}}}
                     ])
  end

end
