class AddChecklistsSlugPublishedAtIndex < ActiveRecord::Migration[8.0]
  def change
    add_index :checklists, [ :slug, :published_at ]
  end
end
