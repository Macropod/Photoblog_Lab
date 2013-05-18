class AddStartDateToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :start_date, :date
    add_index :galleries, :start_date
  end
end
