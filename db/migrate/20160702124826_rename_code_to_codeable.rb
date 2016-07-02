class RenameCodeToCodeable < ActiveRecord::Migration
  def change
    rename_column(:class_files, :code_type, :codeable_type)
    rename_column(:class_files, :code_id, :codeable_id)
  end
end
