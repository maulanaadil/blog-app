require "rails_helper"

RSpec.feature "Signed user edit a article", :type => :feature do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:another_article) { create(:article, user: another_user) }
  before(:each) { sign_in user }

  scenario 'user try to edit his article', js: true do
    article
    visit articles_path
    
    find('a[href="/articles/1"]').click
    find('a[href="/articles/1/edit"]').click
    
    fill_in 'article[title]', with: 'a'
    fill_in 'article[content]', with: 'a'
    
    click_on 'Submit'
    find('.submit-button').click
    visit articles_path

    expect(page).to have_selector('.article-title')
  end

  scenario 'user try to edit not his article', js: true do
    article
    another_article
    visit articles_path

    find('a[href="/articles/2"]').click
    
    expect(page).not_to have_selector('.btn btn-primary me-2')
  end
end

RSpec.feature "Unsigned user try to edit an article", :type => :feature do
  let(:user) { create(:user) }

  scenario 'Unsigned user try to visit article path and cannot edit any article', js: true do
    visit articles_path

    expect(page).to have_text('You must be signed in to do that.')
    expect(page).to have_text('Sign In')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
  
    expect(page).not_to have_selector('.btn btn-primary me-2')
  end
end