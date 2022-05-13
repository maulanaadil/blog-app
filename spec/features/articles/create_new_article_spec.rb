require "rails_helper"

RSpec.feature "Create a new article", :type => :feature do
  let(:user) { create(:user) }
  before(:each) { sign_in user }

  scenario 'user creates a new article', js: true do
    visit articles_path
    
    find('#new-article-button').click
    
    create(:category, name: 'category', branch: 'testing')
    fill_in 'article[title]', with: 'a' * 20
    fill_in 'article[content]', with: 'a' * 20
    # select 'category', from: 'article[category_id]' 

    click_on 'Submit'
    find('.submit-button').click
    expect(page).to have_selector('.article-title', text: 'a' * 20)
  end

end