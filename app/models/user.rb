class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :password, :password_confirmation
  belongs_to :team

  has_many :project_users
  has_many :projects, -> { active.order("LOWER(title)") }, through: :project_users

  scope :active, -> { where.not(deleted: true) }

  def full_name
    "#{first_name} #{last_name}"
  end
end
