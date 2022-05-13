require 'rails_helper'
include Warden::Test::Helpers
RSpec.describe "edit", :type => :request do

  context 'non-signed in user' do
    it 'redirects to a sign in path' do
      get '/articles/1/edit'
      expect(response).to redirect_to(new_user_session_path)
    end
  end

# TODO: 
# Ini bingung gimana ngemocking article sebelum testingnya berjalan
# jadi si get /articles/(id_article)/edit itu harus ada id_articlenya
# nah maka itu sebelumnya harus create dulu article(biar ada id) agar
# ke link endpoint edit tersebut. Tapi gimana caranya gitu hehe

#   context 'signed in user' do
#     let(:user) { create(:user) }
#     before(:each) { login_as user }

#     it 'renders a edit template' do
#       get '/articles/1?1/edit'
#       expect(response).to render_template(:edit)
#     end
#   end

end