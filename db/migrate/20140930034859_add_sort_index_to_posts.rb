class AddSortIndexToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :sort_index, :integer, :default => 0
    add_index :posts, :sort_index
  end
end
