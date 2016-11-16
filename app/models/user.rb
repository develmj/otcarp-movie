class User < ActiveRecord::Base

  def self.attr_list
    [:first_name,
     :last_name,
     :email,
     :age,
     :gender
    ]
  end

  def self.new_entry(params)
    attr_list = User.attr_list
    if params.to_a.empty? or ([:email].map {|attr| params[attr] }.compact.count <  attr_list.count)
      return { status: nil, msg: "Email address is needed for user creation!" }
    else
      attr_list.create(attr_list.reduce({}){|acc,x| acc[x] = params[x];acc})
      return { status: true, msg: "User with email address #{params[:email]} has been added!" }
    end
  end

  def self.search(params)
    return { status: nil, msg: "Need some detail to search for a user!" } if params.to_a.empty? or params.is_a?(Hash)

    attr_list = User.attr_list
    attr_map = attr_list.inject({}) { |acc,attr| acc[attr] = params[attr] if params[attr]; acc }

    return { status: nil, msg: "Invalid search parameters given!" } if attr_map.empty?

    if params[:page].to_i > 0 and params[:page_size].to_i > 0
      payload = User.where(attr_map).limit(params[:page_size]).offset(params[:page])
      total_count = User.where(attr_map).count
    else
      payload = User.where(attr_map)
      total_count = payload.count
    end

    return { status: true, msg: "#{total_count} users found!", payload: payload }
  end

  def self.add_movie_review(params)
    return { status: nil, msg: "Need some detail to add a review!" } if params.to_a.empty? or not params.is_a?(Hash)
    return { status: nil, msg: "Parameters email, review and movie title are missing!" } unless (params[:title] and params[:email] and params[:review])

    movie = Movie.where(title: params[:title])
    return { status: nil, msg: "No such movie found!" } unless movie

    user = User.where(email: params[:email])
    return { status: nil, msg: "No such user found!" } unless user

    resp = Review.add_movie_review(user_id: user.id, movie: movie.id, review: params[:review])

    return { status: true, msg: "Review has been added to movie #{movie.title}" } if resp
    return { status: nil, msg: "Error occurred while adding a review to #{movie.title}" }
  end

  def self.get_recommended_movies(params)
    return { status: nil, msg: "Need some detail to search for a user!" } if params.to_a.empty or not params.is_a?(Hash)
    return { status: nil, msg: "No email id given to search for the user!" } unless params[:email]

    user = User.find_by_email(params[:email])
    if user
      rated_movies = Rating.get_user_movies(user.id)
      if rated_movies.empty?
        return { status: true, msg: "User has not rated anything. Getting top 10 movies ever rated", payload: Rating.get_best_movies }
      else
        return { status: true, msg: "Recommended movies as follows", payload: Movie.get_similar(rated_movies) }
      end
    else
      return { status: nil, msg: "No such user found. Can't recommend anything" }
    end
  end

  def self.vote_review(params, vote_type = :up)
    return { status: nil, msg: "Need some detail to search for the review!" } if params.to_a.empty or not params.is_a?(Hash)
    return { status: nil, msg: "Need some detail to search for the review!" } unless (params[:email] and params[:title])

    movie = Movie.find_by_title(params[:title])
    user = User.find_by_email(params[:email])

    if movie and user
      resp = Rating.update_review(movie.id, user.id, vote_type)
      return { status: nil, msg: "Error in #{vote_type.to_s}voting the review" } unless resp
    else
      return { status: nil, msg: "Did not find either user of movie" }
    end
  end
end
