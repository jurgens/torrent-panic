class AddSeedsToReleases < ActiveRecord::Migration[5.1]
  def change
    add_column :releases, :seeds, :integer
  end
end
