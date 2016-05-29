class CreateClassFiles < ActiveRecord::Migration
  def change
    create_table :class_files do |t|
      t.text :code
      t.string :filename
      t.integer :task_id

      t.timestamps null: false
    end
  end
end
