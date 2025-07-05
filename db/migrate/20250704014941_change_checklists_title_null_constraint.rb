class ChangeChecklistsTitleNullConstraint < ActiveRecord::Migration[8.0]
  def change
    change_column_null :checklists, :title, false
  end
end
