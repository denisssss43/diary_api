class ChangeNotes < ActiveRecord::Migration[6.0]
  def change
    add_column :notes , :diary_id, :integer
  end
end
