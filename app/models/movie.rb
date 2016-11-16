class Movie < ActiveRecord::Base
  has_and_belongs_to_many :persons, join_table: :persons_movies

  def self.attr_list
    [:title,
     :also_known_as,
     :url,
     :company,
     :countries,
     :filming_locations,
     :genres,
     :languages,
     :length,
     :mpaa_rating,
     :plot,
     :plot_summary,
     :plot_synopsis,
     :poster,
     :rating,
     :release_date,
     :tagline,
     :trailer_url,
     :votes,
     :year
    ]
  end

  def self.new_entry(params)
    attr_list = Movie.attr_list
    if params.to_a.empty? or ([:title, :genres].map {|attr| params[attr] }.compact.count <  attr_list.count)
      return { status: nil, msg: "All parameters need to be given" }
    else
      Movie.create(attr_list.reduce({}){|acc,x| acc[x] = params[x];acc})
      return { status: true, msg: "Movie #{params[:title]} has been added!" }
    end
  end

  def self.update_movie_details(params)
    return { status: nil, msg: "Need the title to update the movie!" } if params.to_a.empty? or not params.is_a?(Hash)
    return { status: nil, msg: "No title given!" } unless params[:title]

    attr_list = Movie.attr_list
    movie = Movie.find_by_title(params[:title])

    if movie
      Movie.update_attributes(attr_list.reduce({}){|acc,x| acc[x] = params[x];acc})
      return { status: true, msg: "Movie was found and its details updated" }
    else
      return { status: nil, msg: "No such movie was found" }
    end
  end

  def self.search(params)
    return { status: nil, msg: "Need some detail to search for the movie!" } if params.to_a.empty?

    attr_list = Movie.attr_list
    attr_map = attr_list.inject({}) { |acc,attr| acc[attr] = params[attr] if params[attr]; acc }

    return { status: nil, msg: "Invalid search parameters given!" } if attr_map.empty?

    if params[:page].to_i > 0 and params[:page_size].to_i > 0
      payload = Movie.where(attr_map).limit(params[:page_size]).offset(params[:page])
      total_count = Movie.where(attr_map).count
    else
      payload = Movie.where(attr_map)
      total_count = payload.count
    end

    return { status: true, msg: "#{total_count} movies found!", payload: payload }
  end

  def self.add_cast(params)
    return { status: nil, msg: "Need the title to find the movie!" } if params.to_a.empty?
    return { status: nil, msg: "No title given!" } unless params[:title]

    movie = Movie.find_by_title(params[:title])
    if movie
      cast = Person.new_cast(params)
      if cast
        movie.persons << cast
      else
        return { status: nil, msg: "Error! Couldn't create a actor/actress." }
      end
    else
      return { status: nil, msg: "Couldn't find the movie!" }
    end
  end

  def self.add_crew(params)
    return { status: nil, msg: "Need the title to find the movie!" } if params.to_a.empty? or not params.is_a?(Hash)
    return { status: nil, msg: "No title given!" } unless params[:title]

    movie = Movie.find_by_title(params[:title])
    if movie
      crew = Person.new_crew(params)
      if crew
        movie.persons << crew
      else
        return { status: nil, msg: "Error! Couldn't create a crewman." }
      end
    else
      return { status: nil, msg: "Couldn't find the movie!" }
    end
  end

  def self.get_average_ratings(params)
    return { status: nil, msg: "Need the title to find the movie!" } if params.to_a.empty? or not params.is_a?(Hash)
    return { status: nil, msg: "No title given!" } unless params[:title]

    movie = Movie.find_by_title(params[:title])
    if movie
      rating = Ratings.get_average_ratings(movie.id)
      if rating
        return { status: true, msg: "Movie found. Ratings as follows", rating: rating }
      else
        return { status: nil, msg: "Something went wrong with getting the ratings!" }
      end
    else
      return { status: nil, msg: "No such movie found!" }
    end
  end

  def self.get_reviews(params)
    return { status: nil, msg: "Need the title to find the movie!" } if params.to_a.empty? or not params.is_a?(Hash)
    return { status: nil, msg: "No title given!" } unless params[:title]

    movie = Movie.find_by_title(params[:title])
    if movie
      reviews = Reviews.get_paginated_reviews(movie.id, params[:page_size], params[:cur_page])
      if reviews
        return { status: true, msg: "Movie found. Reviews as follows", reviews: reviews[:data], current_page: reviews[:cur_page], page_size: reviews[:page_size] }
      else
        return { status: nil, msg: "Something went wrong with getting the reviews!" }
      end
    else
      return { status: nil, msg: "No such movie found!" }
    end
  end

  def self.get_similar(rated_movies)
    return nil if rated_movies.to_a.empty?

    genres = Movie.where(id: rated_movies).map(&:genres).compact.distinct
    similar_movies = Movie.where(genre: genres)

    if similar_movies
      return { status: true, msg: "Similar movies found", payload: similar_movies }
    else
      return { status: nil, msg: "No movies found" }
    end
  end

end
