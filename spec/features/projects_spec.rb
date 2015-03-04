require 'rails_helper'

feature 'Projects' do

  scenario 'create project' do
      visit projects_path
      expect(page).to have_content('Projects')
      click_on('New Project')

      click_button('Create Project')
      expect(page).to have_content('1 error prohibited this form from being saved:')

      fill_in 'Name', with: 'Encapsulation'
      click_button('Create Project')
      expect(page).to have_content('Project was successfully created')
      expect(current_path).to eq(project_path(Project.last.id))
  end

  scenario 'edit & delete project' do
    
  end


end
