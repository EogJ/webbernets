require 'rails_helper'

describe 'User Sessions' do
  let(:user)       { create(:user) }

  describe 'GET /login' do
    it 'renders the login form' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST user_sessions' do
    context "Log in Details invalid" do 
    
  end
end

