class CreateCustomTexts < ActiveRecord::Migration
  def change
    create_table :custom_texts do |t|
      t.integer :user_id
      t.string :to_phone_number
      t.text :body

      t.timestamps
    end
  end
end
