require 'rails_helper'

describe 'UserSessions#create' do
  let(:user) { create(:user, :with_team) }

  describe 'POST #create' do
    context 'Log in Details invalid' do
      it "doesn't log in the user" do
        post user_sessions_path, params: { email: user.email, password: 'wrong' }

        expect_incorrect_login_details_message
        expect_not_to_access_dashboard
      end
    end

    context 'Log in Details valid' do
      describe "current user" do
        it "logs in the user" do
          post user_sessions_path, params: { email: user.email, password: 'password' }
          expect(@response).to redirect_to dashboard_path
          expect_to_access_dashboard
        end
      end

      describe "deleted user" do
        it "does not log in the user" do
          user.update!(deleted: true)
          post user_sessions_path, params: { email: user.email, password: 'password' }

          expect_incorrect_login_details_message
          expect_not_to_access_dashboard
        end
      end
    end
  end

  def expect_incorrect_login_details_message
    expect(response.body).to include 'Email/Password is incorrect'
  end

  def expect_to_access_dashboard
    get dashboard_path
    expect(response).to have_http_status(:success)
  end

  def expect_not_to_access_dashboard
    get dashboard_path
    expect(response).to redirect_to(root_path)
  end

end

