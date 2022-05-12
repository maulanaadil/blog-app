require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "new", :type => :request do

  context 'non-signed in user' do
    it 'redirects to a sign in path' do
      get '/articles/new'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it 'renders a new template' do
      get '/articles/new'
      expect(response).to render_template(:new)
    end
  end

end