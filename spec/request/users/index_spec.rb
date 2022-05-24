require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "index", :type => :request do
  context 'unsigned user' do
    it 'try to renders a accounts page' do
        get '/accounts/'
        expect(response).to redirect_to(new_user_session_path)
    end
  end
  
  context 'signed in user admin' do
    let(:user) { create(:user, role: 'admin') }
    before(:each) { login_as user }
    it 'renders a accounts page' do
        get '/accounts/'
        expect(response).to render_template(:index)
    end
  end

  context 'signed in user moderator' do
    let(:user) { create(:user, role: 'moderator') }
    before(:each) { login_as user }
    it 'renders a accounts page' do
        get '/accounts/'
        expect(response).to render_template(:index)
    end
  end

  context 'signed in user user' do
    let(:user) { create(:user, role: 'user') }
    before(:each) { login_as user }
    it 'renders a accounts page' do
        get '/accounts/'
        expect(response).to redirect_to(root_path)
    end
  end
end