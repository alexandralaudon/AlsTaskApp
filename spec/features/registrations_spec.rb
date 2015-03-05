require 'rails_helper'

feature 'Registrations' do

  scenario 'sign up successfully' do
    visit sign_up_path
    fill_in "First name", with: 'Isaac'
    fill_in "Last name", with: 'Newton'
    fill_in "Email", with: 'email@hotmail.com'
    fill_in "Password", with: 'calc'
    fill_in "Password confirmation", with: 'calc'
    click_button("Sign Up")
    expect(page).to have_content('You have successfully signed up')
    expect(current_path).to eq(root_path)
  end

  scenario 'sign out successfully' do
  end

  scenario 'sign in successfully' do
  end

end
