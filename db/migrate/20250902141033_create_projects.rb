class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :organization

      t.string :name
      t.integer :status, null: false, default: 0
      t.references :assignee

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
