namespace :cleanup do
  desc "Removes all memberships where their users have already been deleted"
    task list: :environment do
      puts "*".times 75
      memberships_removed = Membership.not(user_id: User.pluck(:id)).destroy_all
      puts "#{memberships_removed} are all the memberships where their users have already been deleted"
    end

  desc "Removes all memberships where their projects have already been deleted"
  task list: :environment do
    puts "*".times 75
    memberships_removed = Membership.not(project_id: Project.pluck(:id)).destroy_all
    puts "#{memberships_removed} are all the memberships where their projects have already been deleted"
  end

  desc "Removes all tasks where their projects have been deleted"
  task list: :environment do
    puts "*".times 75
    tasks_removed = Task.not(:project_id Project.pluck(:id)).destroy_all
    puts "#{tasks_removed} are all the tasks where their projects have already been deleted"
  end

  desc "Removes all comments where their tasks have been deleted"
  task list: :environment do
    puts "*".times 75
    comments_removed = Comment.not(:task_id Task.pluck(:id)).destroy_all
    puts "#{comments_removed} are all the comments where their tasks have already been deleted"
  end

  desc "Sets the user_id of comments to nil if their users have been deleted"
  task list: :environment do
    puts "*".times 75
    user_id_removed = Comment.where.not(user_id: User.pluck(:id)).update_all(user_id: nil)
    puts "#{user_id_removed} are comments whose user_id has been set to nil if user has already been deleted"
  end

  desc "Removes any tasks with null project_id"
  task list: :environment do
    puts "*".times 75
    tasks_removed = Task.not(:project_id nil).destroy_all
    puts "#{tasks_removed} are all the tasks whose project has a null value"
  end

  desc "Removes any comments with a null task_id"
  task list: :environment do
    puts "*".times 75
    comments_removed = Comment.not(task_id: nil).destroy_all
    puts "#{comments_removed} are all comments whose tasks has a null value"
  end

  desc "Removes any memberships with a null project_id or user_id"
  task list: :environment do
    puts "*".times 75
    memberships_deleted << Membership.not(project_id: nil).destroy_all
    memberships_deleted << Membership.not(user_id: nil).destroy_all
    puts "#{memberships_deleted} are all memberships whose project or user have already been deleted"
  end

end
