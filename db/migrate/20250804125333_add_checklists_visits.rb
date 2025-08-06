class AddChecklistsVisits < ActiveRecord::Migration[8.0]
  def change
    add_column :checklists, :visits, :integer, default: 0, null: false
  end
end
