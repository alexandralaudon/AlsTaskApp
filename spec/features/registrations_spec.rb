require 'rails_helper'

feature "Registrations" do

  scenario 'Guest can Sign Up successfully' do
    visit root_path
    within('.navbar') { click_link('Sign Up') }
    fill_in "First name", with: 'Julius'
    fill_in "Last name", with: 'Caesar'
    fill_in "Email", with: 'winning@life.com'
    fill_in "Password", with: 'Et tu Brute?'
    fill_in "Password confirmation", with: 'Et tu Brute?'
    click_button('Sign Up')
    expect(page).to have_content("You have successfully signed up")
  end

  scenario 'Test where you are redirecting to and the flash message' do
    visit root_path
    within('.navbar') { click_link('Sign Up') }
    fill_in "First name", with: 'Julius'
    fill_in "Last name", with: 'Caesar'
    fill_in "Email", with: 'winning@life.com'
    fill_in "Password", with: 'Et tu Brute?'
    fill_in "Password confirmation", with: 'Et tu Brute?'
    click_button('Sign Up')
    expect(page).to have_content("You have successfully signed up")
    within('.jumbotron') { have_content("Your life, organized.")}
  end

  scenario 'Guest can see validation messages' do
    visit sign_up_path
    click_button('Sign Up')
    expect(page).to have_content("First name can't be blank Last name can't be blank Email can't be blank Password can't be blank")
  end

end
