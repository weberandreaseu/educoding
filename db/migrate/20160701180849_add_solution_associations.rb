class AddSolutionAssociations < ActiveRecord::Migration
  def change
    add_column(:class_files, :code_id, :integer)
    add_column(:class_files, :code_type, :string)
  end
end
