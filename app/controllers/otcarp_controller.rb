class OtcarpController < ApplicationController

  def add_movie
    required(params, :title, :genres)
    show_response(Movie.new_entry(params))
  end

  def update_movie
    required(params, :title)
    show_response(Movie.update_movie_details(params))
  end

  def search_for_movie
    show_response(Movie.search(params))
  end

  def add_cast_to_movie
    required(params, :title, :first_name, :last_name)
    show_response(Movie.add_cast(params))
  end

  def add_crew_to_movie
    required(params, :title, :first_name, :last_name, :person_type)
    show_response(Movie.add_crew(params))
  end

  def get_movie_ratings
  end

  def get_movie_reviews
  end

end
