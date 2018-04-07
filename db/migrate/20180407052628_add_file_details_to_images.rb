class AddFileDetailsToImages < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :file_name, :string
    add_column :images, :content_type, :string
    add_column :images, :file_size, :integer
  end
end
