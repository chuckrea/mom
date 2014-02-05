class AddUserIDtoFarmersMarkets < ActiveRecord::Migration
  def change
    add_column :farmers_markets, :user_id, :integer
  end
end
