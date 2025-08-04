class AddChecklistsSlug < ActiveRecord::Migration[8.0]
  def change
    add_column :checklists, :slug, :string, null: true
    add_index :checklists, :slug, unique: true

    Checklist.find_each(&:save)
  end
end
