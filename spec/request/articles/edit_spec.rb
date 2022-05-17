require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "edit", :type => :request do

  context 'non-signed in user' do
    it 'redirects to a sign in path' do
      get '/articles/1/edit'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    let(:category) { create(:category) }
    before(:each) { login_as user }

    it 'renders a edit template' do
      article = create(:article, user: user, category: category)
      get edit_article_path(article)
      expect(response).to render_template(:edit)
    end
  end

end