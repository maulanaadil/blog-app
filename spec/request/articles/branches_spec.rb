require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "branches", :type => :request do

  shared_examples 'render_templates' do
    it 'renders a hobby template' do
      get '/articles/hobby'
      expect(response).to render_template(:hobby)
    end

    it 'renders a study template' do
      get '/articles/study'
      expect(response).to render_template(:study)
    end

    it 'renders a team template' do
      get '/articles/team'
      expect(response).to render_template(:team)
    end
  end

  context 'non-signed in user' do
    it 'redirects to a sign in path' do
      get '/articles/hobby'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user' do
    let(:user) { create(:user) }
    before(:each) { login_as user }

    it_behaves_like 'render_templates'
  end

end