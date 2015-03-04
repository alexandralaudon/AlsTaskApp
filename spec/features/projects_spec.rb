require 'rails_helper'

feature 'Projects' do

  scenario 'create project' do
      visit projects_path
      expect(page).to have_content('Projects')

  end

  scenario 'edit & delete project' do

  end


end
