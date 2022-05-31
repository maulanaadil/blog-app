require "rails_helper"

RSpec.feature "Search a article", :type => :feature do
    let(:user) { create(:user) }
    let(:category) { create(:category, name: "mock category") }
    let(:article) { create(:article, title: "mock title", user: user, category: category) }
    let(:other_article) { create_list(:article, 5) }
    before(:each) { 
        sign_in user
    }
  
    scenario 'user try to search a article', js: true do
      article
      other_article
      visit articles_path
      
      fill_in 'search', with: "mock title"
      select 'mock category', from: 'category' 

      find('#search').click

      keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('body').trigger(e);"
      page.driver.execute_script(keypress)
  
      expect(page).to have_selector('#article-title', text: "mock title")
      expect(page).to have_selector('#article-category', text: 'mock category')
      expect(page).to have_selector('#article-content', text: article.content)
    end
  end