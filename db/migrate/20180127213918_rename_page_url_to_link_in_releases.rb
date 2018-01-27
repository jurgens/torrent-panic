class RenamePageUrlToLinkInReleases < ActiveRecord::Migration[5.1]
  def change
    rename_column :releases, :page_url, :link
  end
end
