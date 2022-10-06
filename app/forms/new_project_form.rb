class NewProjectForm < BaseForm
  include ActiveModel::Validations::Callbacks

  attribute :title
  attribute :visibility
  attribute :current_user
  attribute :join_project

  before_validation -> { self.title = title&.strip }

  validates :title, presence: true

  def persist
    ActiveRecord::Base.transaction do
      project = Project.create!(title: title, team: current_user.team, public_feed: public_feed)
      if add_user_to_project?
        ProjectUser.create!(user: current_user, project: project)
      end
      project
    end
  end

  private

  def public_feed
    visibility == 'Public'
  end

  def add_user_to_project?
    !current_user.super_user || join_project?
  end

  def join_project?
    ActiveModel::Type::Boolean.new.cast(join_project)
  end
end
