class CreatePersonsMovies < ActiveRecord::Migration
  def change
    create_table :persons_movies do |t|
      t.integer :person_id
      t.integer :movie_id
      t.string :relation_capacity
      t.timestamps null: false
    end
  end
end
