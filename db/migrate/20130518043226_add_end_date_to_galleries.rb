class AddEndDateToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :end_date, :date
    add_index :galleries, :end_date
  end
end
