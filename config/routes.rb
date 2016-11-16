Rails.application.routes.draw do
  api_version(:module => "API::V1", :path => {:value => "v1"}, :default => true) do
    namespace :bdmi do

      resources :otcarp do
        collection do
          post 'add_movie'
          post 'update_movie'
          get 'search_for_movie'
          post 'add_cast_to_movie'
          post 'add_crew_to_movie'
          get 'get_movie_ratings'
          get 'get_movie_reviews'
        end
      end

      resources :userpart do
        collection do
          post 'add_user'
          get 'search_for_user'
          post 'add_review_to_movie'
          get 'get_movie_ratings'
          get 'get_movie_reviews'
          get 'get_recommended_movies'
          post 'upvote_review'
          post 'downvote_review'
        end
      end

    end
  end
end
