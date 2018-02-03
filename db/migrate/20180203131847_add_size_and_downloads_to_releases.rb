class AddSizeAndDownloadsToReleases < ActiveRecord::Migration[5.1]
  def change
    add_column :releases, :size, :integer
    add_column :releases, :downloads, :integer
  end
end
