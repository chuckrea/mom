class ChangeDefaultWeatherInUsers < ActiveRecord::Migration
  def change
    change_column :users, :weather, :boolean, :default => false
  end
end
