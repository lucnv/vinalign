class CreateExperts < ActiveRecord::Migration[5.1]
  def change
    create_table :experts do |t|
      t.string :first_name
      t.string :last_name
      t.string :avatar
      t.string :title
      t.string :workplace
      t.string :facebook_url
      t.string :address
      t.references :district, foreign_key: true

      t.timestamps
    end
  end
end
