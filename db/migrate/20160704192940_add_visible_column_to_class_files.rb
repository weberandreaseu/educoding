class AddVisibleColumnToClassFiles < ActiveRecord::Migration
  def up
    add_column(:class_files, :visible, :boolean, default: true)
  end
end
