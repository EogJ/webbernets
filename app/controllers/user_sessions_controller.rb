class UserSessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]
  layout 'layouts/login_layout'

  def new
    redirect_back_or_to(dashboard_path) if logged_in?
  end

  def create
    if login(params[:email], params[:password])
      redirect_back_or_to(dashboard_path)
    else
      failed_login
    end
  end

  def destroy
    logout
    redirect_to login_path, notice: 'Logged out!'
  end

  def failed_login
    @failed_login = true
    render action: 'new'
  end
end
