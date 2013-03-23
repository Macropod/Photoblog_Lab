class AddGroupsToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :family, :boolean, default: false
    add_column :posts, :friends, :boolean, default: false
    add_column :posts, :others, :boolean, default: true
  end
end
