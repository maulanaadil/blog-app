require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "show", :type => :request do
  context 'unsigned' do
    let(:user) { create(:user, role: 'user') }
    
    it 'renders a edit accounts page' do
        get user_edit_role_path(user)
        expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user admin' do
    admin = FactoryGirl.create(:user, role: 'admin')
    let(:user) { create(:user, role: 'user') }
    before(:each) { login_as admin }
    
    it 'update a details accounts page' do
        get user_edit_role_path(user)
        expect(response).to render_template(:edit)
    end
  end

  context 'signed in user admin' do
    moderator = FactoryGirl.create(:user, role: 'moderator')
    let(:user) { create(:user, role: 'user') }
    before(:each) { login_as moderator }
    
    it 'update a details accounts page' do
        get user_edit_role_path(user)
        expect(response).to render_template(:edit)
    end
  end

  context 'signed in user admin' do
    user_sign = FactoryGirl.create(:user, role: 'user')
    let(:user) { create(:user, role: 'user') }
    before(:each) { login_as user_sign }
    
    it 'update a details accounts page' do
        get user_edit_role_path(user)
        expect(response).to redirect_to(root_path)
    end
  end
end