module Api
  module V1
    module Movie
      class OtcarpController < API::V1::MOVIE::MovieBaseController

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
          required(params, :title)
          show_response(Movie.get_average_ratings(params))
        end

        def get_movie_reviews
          required(params, :title)
          show_response(Movie.get_reviews(params))
        end

      end
    end
  end
end
