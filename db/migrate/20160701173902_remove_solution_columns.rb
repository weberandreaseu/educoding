class RemoveSolutionColumns < ActiveRecord::Migration
  def change
    remove_column(:tasks, :solution_id)
    remove_columns(:users, :task_id, :solution_id)
    remove_column(:class_files, :solution_id)
    remove_column(:class_files, :task_id)
  end
end
