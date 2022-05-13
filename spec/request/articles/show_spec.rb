require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "show", :type => :request do

  context 'non-signed in user' do
    it 'redirects to a sign in path' do
      get '/articles/'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    let(:article) { create(:article) }
    before(:each) { login_as user }

    it 'renders a show' do
        
      get article_path(article)
      expect(response).to render_template(:show)
    end
  end
end