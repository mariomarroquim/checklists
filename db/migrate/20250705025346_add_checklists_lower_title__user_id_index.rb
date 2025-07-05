class AddChecklistsLowerTitleUserIdIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :checklists, "lower(title), user_id", name: :index_checklists_lower_title__user_id, unique: true
  end
end
