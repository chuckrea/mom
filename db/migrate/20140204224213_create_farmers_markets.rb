class CreateFarmersMarkets < ActiveRecord::Migration
  def change
    create_table :farmers_markets do |t|
      t.string :location
      t.string :market_name
      t.string :operation_hours

      t.timestamps
    end
  end
end
