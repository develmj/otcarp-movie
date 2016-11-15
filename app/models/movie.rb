class Movie < ActiveRecord::Base
  has_and_belongs_to_many :persons, join_table: :persons_movies

end
