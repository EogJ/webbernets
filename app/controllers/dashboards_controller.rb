class DashboardsController < ApplicationController
  layout 'backstage_bare'
  def show
    projects = ProjectsQuery.new(user: current_user, all_active: params[:all_active]).records
    @facade = OpenStruct.new(
      projects: projects,
      team: current_user.team,
      super_user: current_user.super_user
    )
  end
end
