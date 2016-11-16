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

  def get_rate_movie
    required(params, :title)
  end

  def get_recommended_movies
  end

  def get_recommended_movies_for
  end

  def upvote_review
  end

  def downvote_review
  end

end
