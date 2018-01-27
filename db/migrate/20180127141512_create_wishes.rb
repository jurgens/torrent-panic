class CreateWishes < ActiveRecord::Migration[5.1]
  def change
    create_table :wishes do |t|
      t.belongs_to :users, index: true, foreign_key: true
      t.belongs_to :movies, index: true, foreign_key: true
      t.timestamp :notified_at

      t.timestamps
    end
  end
end
