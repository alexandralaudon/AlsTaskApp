
def create_user(options={})
  defaults = {
    first_name:'Muhammad',
    last_name: 'Ali',
    email: 'bam@pow.com',
    password: 'ouch',
    password_confirmation: 'ouch'
  }
  User.create(defaults.merge(options))
end

def create_and_sign_in_user
  create_user
  visit sign_in_path
  fill_in "Email", with: 'bam@pow.com'
  fill_in "Password", with: 'ouch'
  click_button('Sign In')
end

def create_project(options={})
  defaults = {
  name: "Abstraction"
  }
  Project.create!(defaults.merge(options))
end

def create_task(project,options={})
  defaults = {
    description: "Simplifying complex reality",
    due_date: '01/01/2000',
    project_id: project.id
  }
  Task.create!(defaults.merge(options))
end

def create_comment(task,user,options={})
  defaults = {
    message: 'let me Google that for you',
    task_id: task.id,
    user_id: user.id
  }
  Comment.create!(defaults.merge(options))
end

def create_membership(project, user, options={})
  defaults = {
    project_id: project.id,
    user_id: user.id,
    role: "Owner"
  }
  Membership.create!(defaults.merge(options))
end
