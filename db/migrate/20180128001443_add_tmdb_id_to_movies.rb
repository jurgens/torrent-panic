class AddTmdbIdToMovies < ActiveRecord::Migration[5.1]
  def change
    add_column :movies, :tmdb_id, :integer, unique: true
  end
end
