class ProjectsQuery
  def initialize(user:, all_active: false)
    @user = user
    @all_active = ActiveModel::Type::Boolean.new.cast(all_active)
  end

  def records
    if show_all_active?
      Project.active.order("LOWER(title)")
    else
      @user.projects
    end
  end

  private

  def show_all_active?
    @user.super_user && @all_active
  end
end
