class AddMainFileToTask < ActiveRecord::Migration
  def change
    add_column(:tasks, :package, :string)
    add_column(:tasks, :main, :string)
  end
end
