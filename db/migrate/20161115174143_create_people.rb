class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :person_class, limit: 255
      t.string :person_type, limit: 255
      t.string :country
      t.string :language
      t.datetime :dob
      t.timestamps null: false
    end
  end
end
