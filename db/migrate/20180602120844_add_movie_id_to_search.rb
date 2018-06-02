class AddMovieIdToSearch < ActiveRecord::Migration[5.1]
  def change
    add_column :searches, :movie_id, :integer
    add_index :searches, :movie_id
  end
end
