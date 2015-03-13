require 'rails_helper'

feature 'Tasks' do

  scenario 'User creates a task' do
    user1 = create_and_sign_in_user
    proj1 = create_project

    visit projects_path
    click_on("Abstraction")
    click_on '0 Tasks'

    within(".breadcrumb") {have_content("Projects Abstraction Tasks")}
    click_link "New Task"

    click_button('Create Task')
    expect(page).to have_content('1 error prohibited this form from being saved:')

    fill_in "Description", with: 'Work hard, play hard'
    fill_in "Due date", with: "12/12/2015"
    click_button('Create Task')
    expect(page).to have_content('Task was successfully created!')
    expect(page).to have_content('Projects Abstraction Tasks Work hard, play hard')
  end

  scenario 'User edits and deletes a task' do
    user1 = create_and_sign_in_user
    proj1 = create_project
    task1 = create_task(proj1)

    visit projects_path
    click_link "Abstraction"
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
