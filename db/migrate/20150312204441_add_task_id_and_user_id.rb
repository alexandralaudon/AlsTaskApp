class AddTaskIdAndUserId < ActiveRecord::Migration
  def change
    add_column :comments, :user_id, :integer
    add_column :comments, :task_id, :integer
  end
end
