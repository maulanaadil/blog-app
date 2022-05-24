require "rails_helper"

RSpec.feature "Create a new article", :type => :feature do
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