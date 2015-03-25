require 'rails_helper'

feature 'Tasks' do

  before :each do
    @user = create_user
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')
  end

  scenario 'User creates a task' do
    project = Project.create!(name: 'Encapsulation')
    membership = create_membership(project, @user)

    visit projects_path
    within('.table') {click_on('Encapsulation')}
    click_on '0 Tasks'

    within(".breadcrumb") {have_content("Projects Abstraction Tasks")}
    click_link "New Task"

    click_button('Create Task')
    expect(page).to have_content('1 error prohibited this form from being saved:')

    fill_in "Description", with: 'Work hard, play hard'
    fill_in "Due date", with: "12/12/2015"
    click_button('Create Task')
    expect(page).to have_content('Task was successfully created!')
    expect(page).to have_content('Work hard, play hard')
  end

  scenario 'User edits and deletes a task' do
    project = Project.create!(name: 'Encapsulation')
    task = create_task(project)
    membership = create_membership(project, @user)

    visit projects_path
    within('.table') {click_link "Encapsulation"}
    click_on "1 Task"

    click_on('Simplifying complex reality')
    click_on('Edit Task')
    fill_in "Description", with: 'modeling classes appropriate to the problem'
    fill_in "Due date", with: "12/12/2015"
    click_button('Update Task')
    expect(page).to have_content('Task was successfully updated!')
    expect(page).to have_content('modeling classes appropriate to the problem')
    within(".breadcrumb") {click_link "Tasks"}

    # Delete task
    page.find(".glyphicon-remove").click
    expect(page).to have_content('Task was successfully deleted!')
    expect(page).to have_no_content('modeling classes appropriate to the problem')

  end

end
