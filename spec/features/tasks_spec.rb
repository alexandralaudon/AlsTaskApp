require 'rails_helper'

feature 'Tasks' do

  scenario 'User creates a task' do
    visit tasks_path
    expect(page).to have_no_content('go work hard')
    click_on('New Task')
    expect(current_path).to eq(new_task_path)


  end

end
