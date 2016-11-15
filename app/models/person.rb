class Person < ActiveRecord::Base
  has_and_belongs_to_many :movies, join_table: :persons_movies
end
