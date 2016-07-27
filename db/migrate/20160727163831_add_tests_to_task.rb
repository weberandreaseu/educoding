class AddTestsToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :basic_test, :text
    add_column :tasks, :advanced_test, :text
    add_column :tasks, :stdin, :text
  end
end
