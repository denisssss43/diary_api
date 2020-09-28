class ChangeNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :text
      t.references :diary
      t.timestamps
    end
  end
end
