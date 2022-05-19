require "rails_helper"
require 'pry'

RSpec.feature "Visit single article and delete it", :type => :feature do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: 'admin') }
  let(:article) { create(:article) }

  scenario "User as User role goes to a single article from the home page then can't go delete for the article", js: true do
    article
    user
    visit root_path
    
    find('nav a', text: 'Sign In').click
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    find('.login-button').click
    
    find('nav a', text: 'Articles').click
    
    find('a[href="/articles/1"]').click

    expect(page).not_to have_selector('button.button-delete')
  end

  scenario "User as Admin role goes to a single article from the home page then can go delete for the article", js: true do
    article
    admin
    visit root_path
    
    find('nav a', text: 'Sign In').click
    fill_in 'user[email]', with: admin.email
    fill_in 'user[password]', with: admin.password
    find('.login-button').click
    
    find('nav a', text: 'Articles').click
    
    find('a[href="/articles/1"]').click
    find('button.button-delete').click
    expect(page).not_to have_selector('#single-article-content p', text: article.content)
  end

end