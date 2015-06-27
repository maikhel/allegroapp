class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.integer :user_id
      t.string :token
      t.datetime :token_expires_at

      t.timestamps null: false
    end
  end
end
