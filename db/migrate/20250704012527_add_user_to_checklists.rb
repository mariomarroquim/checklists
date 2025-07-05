class AddUserToChecklists < ActiveRecord::Migration[8.0]
  def change
    add_column :checklists, :user_id, :bigint, null: false
    add_index :checklists, :user_id
  end
end
