class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.references :treatment_phase, foreign_key: true
      t.bigint :sender_id
      t.text :content

      t.timestamps
    end

    add_index :messages, :sender_id
  end
end
