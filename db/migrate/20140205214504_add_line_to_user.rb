class AddLineToUser < ActiveRecord::Migration
  def change
    add_column :users, :line, :string
  end
end
