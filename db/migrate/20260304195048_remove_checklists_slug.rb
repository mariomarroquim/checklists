class RemoveChecklistsSlug < ActiveRecord::Migration[8.1]
  def change
    remove_index :checklists, :slug
    remove_index :checklists, %i[slug published_at]
    remove_column :checklists, :slug
  end
end
