class CreateProducts < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.date :ending_time
      t.string :thumb_url
      t.string :link
      t.integer :allegro_id

      t.timestamps null: false
    end
  end
end
