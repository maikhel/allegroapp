class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :product_id
      t.string :name
      t.decimal :price
      t.date :ending_time
      t.string :thumb_url
    end
  end
end
