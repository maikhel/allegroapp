class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|

        t.integer :product_id
  	  t.string :name
  	  t.decimal :price
  	  t.decimal :ending_time
  	  t.string :thumb_url
        t.timestamps null: false
    
    end
  end
end
