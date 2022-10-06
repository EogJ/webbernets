module ProjectUsers
  class IndexFacade
    def initialize(params)
      @params = params
    end

    def project
      @project ||= Project.find_by(public_key: @params[:project_public_id])
    end

    def users
      project.users.order(:first_name)
    end

    def available_users
      team.users.where.not(id: project.users.ids)
    end

    def team
      @team ||= project.team
    end
  end
end
