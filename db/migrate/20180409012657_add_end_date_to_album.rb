class AddEndDateToAlbum < ActiveRecord::Migration[5.1]
  def change
    add_column :albums, :end_date, :date
  end
end
