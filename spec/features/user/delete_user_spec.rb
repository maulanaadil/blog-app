require "rails_helper"
require 'pry'

RSpec.feature "Admin visit accounts page and delete user", :type => :feature do
  let(:admin) { create(:user, role: 'admin') }
  let(:moderator) { create(:user, role: 'moderator') }
  let(:user) { create(:user) }
  before(:each) { sign_in admin }

  scenario "Admin goes to a accounts page then go delete another user that have role user", js: true do
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

  scenario "Admin goes to a accounts page then go delete another user that have role moderator", js: true do
    moderator
    visit accounts_path

    find('#email_2').click

    expect(page).to have_selector('#email', text: moderator.email)
    expect(page).to have_selector('#role', text: moderator.role)
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).to have_selector('#button-delete', text: 'Delete')

    find('#button-delete').click

    expect(page).not_to have_selector('#email', text: moderator.email)
    expect(page).not_to have_selector('#role', text: moderator.role)
    expect(page).not_to have_selector('#button-edit', text: 'Edit')
    expect(page).not_to have_selector('#button-delete', text: 'Delete')
  end
end

RSpec.feature "Moderator visit accounts page and delete user", :type => :feature do
  let(:moderator) { create(:user, role: 'moderator') }
  let(:user) { create(:user) }
  before(:each) { sign_in moderator }

  scenario "Moderator goes to a accounts page then cannot delete another user that have role user", js: true do
    user
    visit accounts_path

    find('#email_2').click

    expect(page).to have_selector('#email', text: user.email)
    expect(page).to have_selector('#role', text: user.role)
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).not_to have_selector('#button-delete', text: 'Delete')
  end
end

RSpec.feature "User visit accounts page and delete user", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  scenario "User goes to a accounts page then cannot delete another user that have role user", js: true do
    user
    visit accounts_path

    expect(page).not_to have_selector('#email', text: user.email)
    expect(page).not_to have_selector('#role', text: user.role)
    expect(page).not_to have_selector('#button-edit', text: 'Edit')
    expect(page).not_to have_selector('#button-delete', text: 'Delete')
  end
end