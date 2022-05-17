require 'rails_helper'
require 'pry'
include Warden::Test::Helpers

RSpec.describe "show", :type => :request do
  context 'signed in user admin' do
    let(:user) { create(:user, role: 'admin') }
    before(:each) { login_as user }
    
    it 'renders a accounts page' do
        get '/accounts/'
        expect(response).to render_template(:index)
    end
  end
end