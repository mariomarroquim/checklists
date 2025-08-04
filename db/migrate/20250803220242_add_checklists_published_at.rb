class AddChecklistsPublishedAt < ActiveRecord::Migration[8.0]
  def change
    add_column :checklists, :published_at, :datetime, null: true
  end
end
