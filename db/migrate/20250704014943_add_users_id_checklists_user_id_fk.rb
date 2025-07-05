class AddUsersIdChecklistsUserIdFk < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :checklists, :users, column: :user_id, primary_key: :id
  end
end
