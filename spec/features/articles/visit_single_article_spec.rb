require "rails_helper"
require 'pry'

RSpec.feature "Visit single article", :type => :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article) }

  scenario "User goes to a single article from the home page", js: true do
    article
    user
    visit root_path
    
    find('nav a', text: 'Sign In').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('.login-button').click
    
    find('nav a', text: 'Articles').click

    find('a[href="/articles/1"]').click
    expect(page).to have_selector('#single-article-content p', text: article.content)
  end
end