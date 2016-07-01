class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :score
      t.integer :task_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
