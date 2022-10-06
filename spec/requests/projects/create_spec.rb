require 'rails_helper'

describe 'Projects#create' do
  let(:user) { create(:user, :with_team) }

  it "creates the project" do
    login_user

    get new_project_path, xhr: true
    expect(response).to have_http_status(:success)

    post projects_path, params: { title: 'A', visibility: 'Public' } , xhr: true
    follow_redirect!

    expect(response.body).to include 'Project created'
  end

  def login_user
    post user_sessions_path, params: { email: user.email, password: 'password' }
  end
end
