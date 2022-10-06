class ActiveProjectsController < ApplicationController
  before_action :redirect_unless_super_user!

  def index
    @projects = Project.active.order("LOWER(title)")
  end

  private

  def redirect_unless_super_user!
    redirect_to root_path unless current_user.super_user
  end
end
