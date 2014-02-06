class AddYelpColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :yelp, :boolean, :default => false
  end
end
