require "rails_helper"

RSpec.feature "Visit single article", :type => :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

#   TODO: Masih bingung gimana cara ngetest element didalem children
#   scenario "User goes to a single article from the home page", js: true do
#     article
#     visit root_path
#     find('nav a', text: 'Articles').click
    
#     find('a[href="/articles/1"]').click
#     expect(page).to have_selector('#single-post-content p', text: article.content)
#   end

end