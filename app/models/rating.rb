class Rating
  include Mongoid::Document
  field :user_id, type: Integer
  field :movie_id, type: Integer
  field :rating, type: Integer
end
