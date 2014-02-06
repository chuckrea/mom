class AddIsAnnoyingToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_annoying, :boolean, :default => false
  end
end
