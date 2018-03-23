class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :summary
      t.text :content
      t.string :represent_image
      t.integer :category

      t.timestamps
    end
  end
end
