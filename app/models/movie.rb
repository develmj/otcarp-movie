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
    return { status: nil, msg: "Need the title to update the movie!" } if params.to_a.empty?

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

    movie = Movie.where(title: params[:title])
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
    return { status: nil, msg: "Need the title to find the movie!" } if params.to_a.empty?

    movie = Movie.where(title: params[:title])
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

end
