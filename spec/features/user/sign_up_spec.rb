require "rails_helper"

RSpec.feature "Sign up", :type => :feature do
  let(:user) { build(:user) }
  let(:another_user) { create(:user, email: "mock@email.com") }

  scenario 'user navigates to sign up page and successfully signs up', js: true do
    visit root_path
    find('nav a', text: 'Sign Up').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation

    find('.sign-up-button').click

    expect(page).to have_selector('#user-settings')
    expect(page).to have_text('Welcome! You have signed up successfully.')
  end

  scenario 'user navigates to sign up page and try to input password that doesn\'t match password', js: true do
    visit root_path
    find('nav a', text: 'Sign Up').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: "mock confirm password"

    find('.sign-up-button').click

    expect(page).to have_text('Password confirmation doesn\'t match Password')
  end

  scenario 'user navigates to sign up page and try to input email that already been taken', js: true  do
    visit root_path
  
    find('nav a', text: 'Sign Up').click
    fill_in 'user[email]', with: "mock@email.com"
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password_confirmation

    find('.sign-up-button').click

    expect(page).to have_text('Email has already been taken')
  end

  scenario 'user navigates to sign up page and try to input password and confirm password that contains less than 6 characters', js: true do
    visit root_path
    find('nav a', text: 'Sign Up').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: "12345"
    fill_in 'user[password_confirmation]', with: "12345"

    find('.sign-up-button').click

    expect(page).to have_text('Password is too short (minimum is 6 characters)')
  end
end