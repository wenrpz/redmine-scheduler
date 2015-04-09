class CreateTempIssues < ActiveRecord::Migration
  def change
    create_table :temp_issues do |t|
      t.integer :pid
      t.string :name
      t.text :description
      t.float :duration
      t.string :assigned_to
      t.string :start_date
      t.string :end_date
      t.references :project
    end
    add_index :temp_issues, :project_id
  end
end
