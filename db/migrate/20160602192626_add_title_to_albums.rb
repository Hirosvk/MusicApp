class AddTitleToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :title, :string
    add_column :tracks, :title, :string
  end
end
