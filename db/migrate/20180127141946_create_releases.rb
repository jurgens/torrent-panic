class CreateReleases < ActiveRecord::Migration[5.1]
  def change
    create_table :releases do |t|
      t.belongs_to :movies, index: true, foreign_key: true
      t.string :title
      t.string :status
      t.string :page_url
      t.string :magnet
    end
  end
end
