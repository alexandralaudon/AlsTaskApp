class DropColumnProjectIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :project_id, :integer
  end
end
