# Given a project, we need a way to
# easily determine if the provided user
# should have access to it
class UserPermissionToProject
  def initialize(project, user)
    @project = project
    @user = user
  end

  def run
    return false if @user.deleted?

    @user.super_user || @user.projects.include?(@project)
  end
end
