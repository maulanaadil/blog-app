require "rails_helper"

RSpec.feature "Edit a article", :type => :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  before(:each) { sign_in user }

  scenario 'user creates a edit article', js: true do
    article
    visit articles_path
    
    find('a[href="/articles/1"]').click
    find('a[href="/articles/1/edit"]').click
    
    fill_in 'article[title]', with: 'a'
    fill_in 'article[content]', with: 'a'
    # select 'category', from: 'article[category_id]' 

    # TODO: 
    # Dia gamau ngetrigger button submit jadi 
    # dia nggak mau nge expect article-title
    # karena article tersebut belom diedit
    find('button.submit-button').click

    expect(page).to have_selector('.article-title')
  end

end