class ChangeColumnInItems < ActiveRecord::Migration
  def change
  	change_table :items do |t|
	  t.change :allegro_id, :decimal

	end

  end
end
