require 'rails_helper'

feature 'Users' do

  scenario 'Users can be created' do
    visit users_path
    click_on('New User')
    click_button('Create User')
    expect(page).to have_content('3 error prohibited this form from being saved:')

    fill_in 'First name', with: 'Alexandra'
    fill_in 'Last name', with: 'Kestenbaum'
    fill_in 'Email', with: 'akest@baum.com'
    click_button('Create User')

    expect(current_path).to eq(users_path)
    expect(page).to have_content('User was successfully created!')
    expect(page).to have_content('Alexandra Kestenbaum')
  end

  scenario 'Users can be edited and deleted' do
    User.create!(first_name: 'Alexandra', last_name: 'Kestenbaum', email:'akest@baum.com')

    visit users_path
    click_on('Alexandra Kestenbaum')
    expect(page).to have_content('First Name Alexandra')
    expect(page).to have_content('Last Name Kestenbaum')
    click_on('Edit')
    fill_in 'First name', with: 'Sol'
    fill_in 'Last name', with: 'Laudon'
    fill_in 'Email', with: 'slaudon@gmail.com'
    click_button('Update User')
    expect(page).to have_content('User was successfully updated!')
    click_on('Sol Laudon')
    click_on('Edit')
    click_on('Delete User')
    expect(page).to have_content('User was successfully deleted!')
    expect(page).to have_no_content('Sol Laudon')

  end

end
