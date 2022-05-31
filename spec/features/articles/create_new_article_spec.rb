require "rails_helper"

RSpec.feature "User sign in then try to create a new article", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { 
    sign_in user
    create(:category)
  }

  scenario 'user creates a new article', js: true do
    visit articles_path
    
    find('#new-article-button').click
    
    fill_in 'article[title]', with: 'a' * 20
    fill_in 'article[content]', with: 'a' * 20
    select 'test', from: 'article[category_id]' 
    click_on 'Submit'

    expect(page).to have_selector('.article-title', text: 'a' * 20)
  end
end

RSpec.feature "Unsigned user try to create a new article", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { 
    create(:category)
  }

  scenario 'Unsigned user creates a new article', js: true do
    visit articles_path

    expect(page).to have_text('You must be signed in to do that.')
    expect(page).to have_text('Sign In')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
  
    expect(page).not_to have_selector('#new-article-button')
  end
end