

def create_and_sign_in_user
  User.create(first_name:'Muhammad', last_name: 'Ali', email: 'bam@pow.com', password: 'ouch', password_confirmation: 'ouch')
  visit sign_in_path
  fill_in "Email", with: 'bam@pow.com'
  fill_in "Password", with: 'ouch'
  click_button('Sign In')
end

def create_project
  Project.create!(name: "Abstraction")
end

def create_task(project)
  Task.create!(description: "Simplifying complex reality", due_date: '01/01/2000', project_id: project.id)
end
