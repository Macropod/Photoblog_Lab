class AddAccessTokenToPosts < ActiveRecord::Migration
  def change
  	add_column :posts, :access_token, :string
  end
end
