class AddMtaColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mta, :boolean, :default => false
  end
end
