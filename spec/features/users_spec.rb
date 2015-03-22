require 'rails_helper'

feature 'Users' do

  scenario 'can be created' do
    User.create(first_name:'Muhammad', last_name: 'Ali', email: 'bam@pow.com', password: 'ouch', password_confirmation: 'ouch')
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')

    visit users_path
    click_on('New User')
    click_button('Create User')
    expect(page).to have_content('4 errors prohibited this form from being saved:')

    fill_in 'First name', with: 'Alexandra'
    fill_in 'Last name', with: 'Kestenbaum'
    fill_in 'Email', with: 'akest@baum.com'
    fill_in 'Password', with: 'kesten'
    fill_in 'Password confirmation', with: 'kesten'
    click_button('Create User')

    expect(current_path).to eq(users_path)
    expect(page).to have_content('User was successfully created!')
    expect(page).to have_content('Alexandra Kestenbaum')
  end

  scenario 'can be edited and deleted' do
    user1 = User.create(first_name:'Muhammad', last_name: 'Ali', email: 'bam@pow.com', password: 'ouch', password_confirmation: 'ouch')
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')

    visit users_path
    within('.table') {click_on('Muhammad Ali')}
    expect(page).to have_content('First Name Muhammad')
    expect(page).to have_content('Last Name Ali')
    click_on('Edit')
    fill_in 'First name', with: 'Sol'
    fill_in 'Last name', with: 'Laudon'
    fill_in 'Email', with: 'slaudon@gmail.com'
    click_button('Update User')
    expect(page).to have_content('User was successfully updated!')

    #Delete functionality
    within('.table') {click_on('Sol Laudon')}
    click_on('Edit')
    click_on('Delete User')
    expect(page).to have_content('User was successfully deleted!')
    expect(page).to have_no_content('Sol Laudon')

  end

end
