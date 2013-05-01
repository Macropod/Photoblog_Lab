class AddGalleryIdToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :gallery_id, :integer
  	add_index :posts, :gallery_id
  end
end
