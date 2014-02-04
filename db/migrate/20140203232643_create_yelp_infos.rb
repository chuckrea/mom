class CreateYelpInfos < ActiveRecord::Migration
  def change
    create_table :yelp_infos do |t|
      t.integer :user_id
      t.string :restaurant_name
      t.string :cuisine_type
      t.string :address

      t.timestamps
    end
  end
end
