require "rails_helper"

RSpec.feature "Signed user that have role User try to visit single article and delete it", :type => :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  before(:each) { 
    sign_in user
  }

  scenario "User as User role goes to a single article from the home page then can't go delete for the article", js: true do
    article
    user
    visit articles_path
    
    find('a[href="/articles/1"]').click

    expect(page).not_to have_selector('button.button-delete')
  end
end

RSpec.feature "Signed user that have role Admin try to visit single article and delete it", :type => :feature do
  let(:admin) { create(:user, role: 'admin') }
  let(:article) { create(:article) }
  before(:each) { 
    sign_in admin
  }


  scenario "User as Admin role goes to a single article from the home page then can go delete for the article", js: true do
    article
    admin
    visit articles_path
    
    find('a[href="/articles/1"]').click
    find('button.button-delete').click

    expect(page).not_to have_selector('#single-article-content p', text: article.content)
  end
end

RSpec.feature "Unsigned user try to create a new article", :type => :feature do
  let(:user) { create(:user) }
  let(:article) { create(:article) }
  before(:each) { 
    create(:category)
  }

  scenario 'Unsigned user try to visit single article and delete it', js: true do
    article
    visit articles_path

    expect(page).to have_text('You must be signed in to do that.')
    expect(page).to have_text('Sign In')
    expect(page).to have_text('Email')
    expect(page).to have_text('Password')
  
    expect(page).not_to have_selector('#single-article-content p', text: article.content)
  end
end