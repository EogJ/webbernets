require 'rails_helper'

describe 'UserSessions#new' do
  describe 'GET #new' do
    it 'renders the login form' do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end
end

