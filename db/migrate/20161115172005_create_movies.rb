class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.text :title
      t.text :also_known_as
      t.string  :url, limit: 4083
      t.text :company
      t.text :countries
      t.text :filming_locations
      t.text :genres
      t.text :languages
      t.integer :length
      t.string :mpaa_rating, limit: 5
      t.text :plot
      t.text :plot_summary
      t.text :plot_synopsis
      t.string :poster, limit: 4083
      t.float :rating
      t.datetime :release_date
      t.text :tagline
      t.string :trailer_url, limit: 4083
      t.integer :votes
      t.integer :year
      t.timestamps null: false
    end
  end
end
