class UserpartController < ApplicationController

  def add_user
    required(params, :email)
    show_response(User.new_entry(params))
  end

  def search_for_user
    show_response(User.search(params))
  end

  def add_review_to_movie
    required(params, :title, :review, :email)
    show_response(User.add_movie_review(params))
  end

  def get_movie_ratings
    required(params, :title)
    show_response(Movie.get_average_ratings(params))
  end

  def get_movie_reviews
    required(params, :title)
    show_response(Movie.get_reviews(params))
  end

  def get_recommended_movies
    required(params, :email)
    show_response(User.get_recommended_movies(params))
  end

  def upvote_review
  end

  def downvote_review
  end

end
