class AddCrawledAtToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :crawled_at, :datetime
  end
end
