require 'rails_helper'

feature 'Authentication' do

  background do
    User.create!(first_name:'William', last_name: 'Shakespeare', email: 'tobe@nottobe.net', password:'that is the question', password_confirmation:'that is the question')
  end

  scenario 'User can Sign In successfully' do
    visit root_path
    within(".navbar") {click_link("Sign In")}
    fill_in "Email", with: 'tobe@nottobe.net'
    fill_in "Password", with: 'that is the question'
    click_button("Sign In")

    within(".alert") {have_content("You have successfully signed in")}
    within('.jumbotron') { have_content("Your life, organized.")}
  end

  scenario 'User can see validation messages' do
      visit sign_in_path
      click_button("Sign In")
      within(".well") {have_content("Email / Password combination is invalid")}
  end

  scenario 'User can sign out successfully' do
    visit root_path
    user1 = create_and_sign_in_user

    visit root_path
    within(".navbar") {click_link("Sign Out")}
    within('.jumbotron') { have_content("Your life, organized.")}
    within(".alert") {have_content("You have successfully logged out")}
  end

end
