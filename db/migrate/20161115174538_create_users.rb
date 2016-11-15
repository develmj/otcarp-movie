class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :limit, limit: 254
      t.integer :age
      t.string :gender, limit: 10
      t.timestamps null: false
    end
  end
end
