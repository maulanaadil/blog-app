require "rails_helper"

RSpec.feature "Login", :type => :feature do
  let(:user) { create(:user) }

  scenario 'user navigates to the login page and succesfully logs in', js: true do
    user
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('.login-button').click

    expect(page).to have_text('Homepage')
    expect(page).to have_text('Signed in successfully.')
  end

  scenario 'user navigates to the login page and try input a wrong password', js: true do
    user
    visit new_user_session_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: "mock password"
    find('.login-button').click

    expect(page).to have_text('Invalid Email or password.')
    expect(page).to have_text('Sign In')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
  end

  scenario 'user navigates to the login page and try input a wrong email', js: true, :altering_database => true do
    user
    visit new_user_session_path

    fill_in 'user[email]', with: "mock email"
    fill_in 'user[password]', with: user.password
    find('.login-button').click

    expect(page).to have_text('Invalid Email or password.')
    expect(page).to have_text('Sign In')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
  end

  scenario 'user navigates to the login page and try to click sign up button', js: true, :altering_database => true do
    user
    visit new_user_session_path

    
    find('#link-to-sign-up').click
    
    expect(page).to have_text('Sign up')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
    expect(page).to have_text('Password confirmation')
  end
end