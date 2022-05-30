require 'rails-helper'
include Warden::Test::Helpers

RSpec.describe "index", :type => :request do
  context 'unsigned' do
    let(:user) { create(:user, role: 'user') }
    
    it 'renders a details accounts page' do
        get user_path(user)
        expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user admin' do
    let(:user) { create(:user, role: 'admin') }
    before(:each) { login_as user }
    
    it 'renders a details accounts page' do
        get user_path(user)
        expect(response).to render_template(:show)
    end
  end

  context 'signed in user admin' do
    let(:user) { create(:user, role: 'moderator') }
    before(:each) { login_as user }
    
    it 'renders a details accounts page' do
        get user_path(user)
        expect(response).to render_template(:show)
    end
  end

  context 'signed in user user' do
    let(:user) { create(:user, role: 'user') }
    before(:each) { login_as user }
    
    it 'renders a details accounts page' do
        get user_path(user)
        expect(response).to redirect_to(root_path)
    end
  end

  context 'user search and filter articles' do
      let(:article) { create(:article, user: user) }

      it 'renders list of articles that have been search' do
          get articles_path

          fill_in "Field",	with: "sometext" 
      end
  end
end