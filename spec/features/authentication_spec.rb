require 'rails_helper'

feature 'Authentication' do

  background do
    User.create!(first_name:'William', last_name: 'Shakespeare', email: 'tobe@nottobe.net', password:'that is the question', password_confirmation:'that is the question')
  end

  scenario 'User can sign out successfully' do
    visit root_path
    within(".navbar") {click_link("Sign In")}
    fill_in "Email", with: 'tobe@nottobe.net'
    fill_in "Password", with: 'that is the question'
    click_button("Sign In")

    within(".navbar") {click_link("Sign Out")}
    expect(current_path).to eq(root_path)
  end

  scenario 'Test where you are redirecting to and the flash message' do
    visit root_path
    within(".navbar") {click_link("Sign In")}
    fill_in "Email", with: 'tobe@nottobe.net'
    fill_in "Password", with: 'that is the question'
    click_button("Sign In")

    within(".navbar") {click_link("Sign Out")}
    within('.jumbotron') { have_content("Your life, organized.")}
    within(".alert") {have_content("You have successfully logged out")}
  end

end
