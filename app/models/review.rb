class Review
  include Mongoid::Document
  field :user_id, type: Integer
  field :movie_id, type: Integer
  field :review, type: String
  field :vote, type: Integer
end
