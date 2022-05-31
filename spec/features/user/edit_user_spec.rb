require "rails_helper"
require 'pry'

RSpec.feature "Admin sign in then try to visit accounts page and edit user", :type => :feature do
  let(:admin) { create(:user, role: 'admin') }
  let(:moderator) { create(:user, role: 'moderator') }
  let(:user) { create(:user) }
  before(:each) { sign_in admin }

  scenario "Admin goes to a accounts page then go find user.email that the role wanted to be changed into User", js: true do
    moderator
    visit accounts_path

    find('#email_2').click

    expect(page).to have_selector('#email', text: moderator.email)
    expect(page).to have_selector('#role', text: moderator.role)
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).to have_selector('#button-delete', text: 'Delete')

    find('#button-edit').click

    expect(page).to have_selector('#email', text: moderator.email)
    select 'User', from: 'user[role]'

    find('#button-update').click

    expect(page).to have_selector('#email', text: moderator.email)
    expect(page).to have_selector('#role', text: 'user')
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).to have_selector('#button-delete', text: 'Delete')
  end

  scenario "Admin goes to a accounts page then go find user.email that the role wanted to be changed into Moderator", js: true do
    user
    visit accounts_path

    find('#email_2').click

    expect(page).to have_selector('#email', text: user.email)
    expect(page).to have_selector('#role', text: user.role)
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).to have_selector('#button-delete', text: 'Delete')

    find('#button-edit').click

    expect(page).to have_selector('#email', text: user.email)
    select 'Moderator', from: 'user[role]'

    find('#button-update').click

    expect(page).to have_selector('#email', text: user.email)
    expect(page).to have_selector('#role', text: 'moderator')
    expect(page).to have_selector('#button-edit', text: 'Edit')
    expect(page).to have_selector('#button-delete', text: 'Delete')
  end
end

RSpec.feature "Moderator sign in then try to visit accounts page and edit user", :type => :feature do
    let(:admin) { create(:user, role: 'admin') }
    let(:moderator) { create(:user, role: 'moderator') }
    let(:user) { create(:user) }
    before(:each) { sign_in moderator }

    scenario "Moderator goes to a accounts page then go find himself to change his role into User", js: true do
        user
        visit accounts_path
    
        find('#email_1').click
    
        expect(page).to have_selector('#email', text: moderator.email)
        expect(page).to have_selector('#role', text: moderator.role)
        expect(page).not_to have_selector('#button-edit', text: 'Edit')
        expect(page).not_to have_selector('#button-delete', text: 'Delete')
      end
  
    scenario "Moderator goes to a accounts page then go find user.email that the role wanted to be changed into Moderator", js: true do
      user
      visit accounts_path
  
      find('#email_2').click
  
      expect(page).to have_selector('#email', text: user.email)
      expect(page).to have_selector('#role', text: user.role)
      expect(page).to have_selector('#button-edit', text: 'Edit')
      expect(page).not_to have_selector('#button-delete', text: 'Delete')
  
      find('#button-edit').click
  
      expect(page).to have_selector('#email', text: user.email)
      select 'Moderator', from: 'user[role]'
  
      find('#button-update').click
  
      expect(page).to have_selector('#email', text: user.email)
      expect(page).to have_selector('#role', text: 'moderator')
      expect(page).to have_selector('#button-edit', text: 'Edit')
      expect(page).not_to have_selector('#button-delete', text: 'Delete')
    end

    scenario "Moderator goes to a accounts page then go find user.email that have admin role and he wanted to changed the role into Moderator", js: true do
        admin
        visit accounts_path
    
        find('#email_2').click
    
        expect(page).to have_selector('#email', text: admin.email)
        expect(page).to have_selector('#role', text: admin.role)
        expect(page).not_to have_selector('#button-edit', text: 'Edit')
        expect(page).not_to have_selector('#button-delete', text: 'Delete')
      end
  end

  RSpec.feature "User sign in then try to visit accounts page and edit user", :type => :feature do
    let(:user) { create(:user) }
    before(:each) { sign_in user }

    scenario "User goes to a accounts page then go find any account that registered", js: true do
        user
        visit accounts_path
    
        expect(page).not_to have_selector('#email', text: user.email)
        expect(page).not_to have_selector('#role', text: user.role)
        expect(page).not_to have_selector('#button-edit', text: 'Edit')
        expect(page).not_to have_selector('#button-delete', text: 'Delete')
      end
  end

  RSpec.feature "Unsigned user try to visit accounts page and edit user without sign in", :type => :feature do
    let(:user) { create(:user) }
  
    scenario "Unsigned user goes to a accounts page then try to edit another user", js: true do
      user
      visit accounts_path
      
      expect(page).to have_text('You must be signed in to do that.')
      expect(page).to have_text('Sign In')
      expect(page).to have_text('Email')
      expect(page).to have_text('Password')
  
      expect(page).not_to have_selector('#email', text: user.email)
      expect(page).not_to have_selector('#role', text: user.role)
      expect(page).not_to have_selector('#button-edit', text: 'Edit')
    end
  end