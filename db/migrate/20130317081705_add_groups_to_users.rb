class AddGroupsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :family, :boolean, default: false
    add_column :users, :friends, :boolean, default: false
    add_column :users, :others, :boolean, default: true
  end
end
