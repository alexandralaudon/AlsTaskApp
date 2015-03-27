require 'rails_helper'

feature 'Users' do
  before :each do
    @user1 = create_user(first_name: 'aaaa', last_name: 'bbbb', email: 'aaaa@bbbb.com')
    @user2 = create_user
  end

  scenario 'can be created' do
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')

    visit users_path
    click_on('New User')
    click_button('Create User')
    expect(page).to have_content('4 errors prohibited this form from being saved:')

    fill_in 'First Name', with: 'Alexandra'
    fill_in 'Last Name', with: 'Kestenbaum'
    fill_in 'Email', with: 'akest@baum.com'
    fill_in 'Password', with: 'kesten'
    fill_in 'Password Confirmation', with: 'kesten'
    click_button('Create User')

    expect(current_path).to eq(users_path)
    expect(page).to have_content('User was successfully created!')
    expect(page).to have_content('Alexandra Kestenbaum')
  end

  scenario 'can be edited and deleted' do
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')

    visit users_path
    within('.table') {click_on('Muhammad Ali')}
    expect(page).to have_content('First Name Muhammad')
    expect(page).to have_content('Last Name Ali')
    click_on('Edit')
    fill_in 'First Name', with: 'Sol'
    fill_in 'Last Name', with: 'Laudon'
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

  scenario 'PERMISSIONS #membership_sharing?' do
    @user2.update_attributes(admin: false)
    visit sign_in_path
    fill_in "Email", with: 'bam@pow.com'
    fill_in "Password", with: 'ouch'
    click_button('Sign In')

    project = create_project
    membership = create_membership(project, @user1, role: 'Member')

    #with no joint memberships
    visit users_path
    expect(page).to_not have_content('aaaa@bbbb.com')

    #with joint memberships
    membership2 = create_membership(project, @user2, role:'Member')
    visit users_path
    expect(page).to have_content('aaaa@bbbb.com')
  end

end
