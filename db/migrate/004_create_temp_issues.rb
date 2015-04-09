class CreateTempIssues < ActiveRecord::Migration
  def change
    create_table :temp_issues do |t|
      t.integer :pid
      t.string :name
      t.text :description
      t.float :duration
      t.string :assigned_to
      t.date :start_date
      t.date :end_date
    end
  end
end
