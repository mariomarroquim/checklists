class AddChecklistsReports < ActiveRecord::Migration[8.0]
  def change
    add_column :checklists, :reports, :integer, default: 0, null: false
  end
end
