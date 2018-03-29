class AddNormalizedFieldsToExperts < ActiveRecord::Migration[5.1]
  def change
    add_column :experts, :normalized_name, :string
    add_column :experts, :normalized_workplace, :string
  end
end
