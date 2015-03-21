require 'rails_helper'

feature 'Projects' do

  before :each do
    @user = User.create(first_name:'Muhammad', last_name: 'Ali', email: 'bam@pow.com', password: 'ouch', password_confirmation: 'ouch')
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')
  end

  scenario 'create project' do
    visit projects_path
    expect(page).to have_content('Projects')
    click_on('New Project', match: :first)

    click_button('Create Project')
    expect(page).to have_content('1 error prohibited this form from being saved:')

    fill_in 'Name', with: 'Encapsulation'
    click_button('Create Project')
    expect(page).to have_content('Project was successfully created')
    expect(current_path).to eq(project_tasks_path(Project.last.id))
  end

  scenario 'edit & delete project' do
    project = Project.create!(name: 'Encapsulation')
    membership = create_membership(project,@user)

    visit projects_path
    within('.table') {click_on('Encapsulation')}
    click_on('Edit')
    fill_in 'Name', with: 'Encapsulate'
    click_button('Update Project')
    expect(page).to have_content('Project was successfully updated')
    expect(page).to have_content('Encapsulate')
    visit projects_path
    expect(page).to have_content('Encapsulate')

    #Delete functionality
    visit project_path(Project.last.id)
    click_on('Delete')
    expect(page).to have_content('Project was successfully deleted')
    expect(page).to have_no_content('Encapsulate')

  end


end
