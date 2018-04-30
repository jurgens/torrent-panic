class CreateSearches < ActiveRecord::Migration[5.1]
  def change
    create_table :searches do |t|
      t.string :text
      t.integer :user_id
      t.integer :status

      t.timestamps

      t.index :user_id
    end
  end
end
