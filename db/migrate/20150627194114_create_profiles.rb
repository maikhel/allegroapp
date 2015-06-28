class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.string :city
      t.string :country
      t.integer :age
      t.string :gender
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
