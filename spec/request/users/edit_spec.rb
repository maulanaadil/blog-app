require 'rails_helper'
include Warden::Test::Helpers

RSpec.describe "edit", :type => :request do
  context 'unsigned' do
    let(:user) { create(:user, role: 'user') }
    
    it 'unsinged user try to edit user role' do
        get user_edit_role_path(user)
        expect(response).to redirect_to(new_user_session_path)
    end
  end

  context 'signed in user admin' do
    let(:user) { create(:user, role: 'user') }
    let(:admin) { create(:user, role: 'admin') }
    before(:each) { login_as admin }
    
    it 'update a details accounts page' do
        get user_edit_role_path(user)
        expect(response).to render_template(:edit)
    end
  end

  context 'signed in user moderator' do
    let(:user) { create(:user, role: 'user') }
    let(:moderator) { create(:user, role: 'moderator') }
    before(:each) { login_as moderator }
    
    it 'update a details accounts page' do
        get user_edit_role_path(user)
        expect(response).to render_template(:edit)
    end
  end

  context 'signed in user user' do
    let(:user_sign) { create(:user, role: 'user') }
    let(:user) { create(:user, role: 'user') }
    before(:each) { login_as user_sign }
    
    it 'update a details accounts page' do
        get user_edit_role_path(user)
        expect(response).to redirect_to(root_path)
    end
  end
end