class AddPriorityIntoExperts < ActiveRecord::Migration[5.1]
  def change
    add_column :experts, :priority, :integer, default: 0
  end
end
