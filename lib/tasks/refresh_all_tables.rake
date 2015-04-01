namespace :refresh do
  desc "Create all new users, projects, tasks, comments, and memberships && associate it them properly"
  task :create_and_associate => :environment do
    require 'faker'

      Membership.destroy_all
      Comment.destroy_all
      Task.destroy_all
      User.destroy_all
      Project.destroy_all

      14.times do |user|
        User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, password: "password", admin: false)
      end
      User.first.update_attributes(admin: true)
      User.create!(first_name: "Emily", last_name: "with the coolest hat", email: "admin@example.com", password: 'password', admin: true)
      user_id_array = User.pluck(:id)
      puts "#{User.count} users generated. User_id_array: #{user_id_array}"

      10.times do |project|
        Project.create!(name: Faker::Company.catch_phrase)
      end
      project_id_array = Project.pluck(:id)
      puts "#{Project.count} projects generated. Project_id_array: #{project_id_array}"

      25.times do |task|
        Task.create!(description: Faker::Hacker.say_something_smart, complete: [true,false].sample, due_date: Faker::Date.forward(30), project_id: project_id_array.sample)
      end
      task_id_array = Task.pluck(:id)
      puts "#{Task.count} tasks generated. Task_id_array: #{task_id_array}"


      75.times do |comment|
        Comment.create!(message: Faker::Company.bs, user_id: user_id_array.sample, task_id: task_id_array.sample)
      end
      puts "#{Comment.count} comments generated"

      membership_role = ['Member', 'Owner']
      40.times do |membership|
        Membership.create(role: membership_role.sample, project_id: project_id_array.sample, user_id: user_id_array.sample)
      end
      puts "#{Membership.count} memberships generated"

  end
end
