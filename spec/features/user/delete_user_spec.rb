require "rails_helper"
require 'pry'

RSpec.feature "Visit accounts page and delete user", :type => :feature do
  # admin = FactoryGirl.create(:user, role: 'admin')
  let(:admin) { create(:user, role: 'admin') }
  let(:user) { create(:user) }
  before(:each) { sign_in admin }

  scenario "Admin goes to a accounts page from the home page then go delete another user", js: true do
    user
    visit accounts_path

    find('#email_2').click

    expect(page).to have_selector('#email', text: user.email)
    expect(page).to have_selector('#role', text: user.role)
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).to have_selector('#button-delete', text: 'Delete')

    find('#button-delete').click

    expect(page).not_to have_selector('#email', text: user.email)
    expect(page).not_to have_selector('#role', text: user.role)
    expect(page).not_to have_selector('#button-edit', text: 'Edit')
    expect(page).not_to have_selector('#button-delete', text: 'Delete')
  end
end